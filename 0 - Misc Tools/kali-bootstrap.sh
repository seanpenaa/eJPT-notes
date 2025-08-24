#!/usr/bin/env bash
# Generated through ChatGPT with the prompt: do you have access to all the tools that I had to download over the past 2 week's work of conversations for linux? this could include packages such as volatility, 
#  or any python libraries. I'm trying to compile a script to run and download for every new installation of kali linux whenever i have to fix it by redownloading
# Kali bootstrap for CTF/pwn/forensics/web work
# - PEP 668 safe (no system pip upgrades)
# - Sublime Text repo + install
# - Recon toolchain + reconwrap helper
# - Chromium-based html2pdf helper
# - pwndbg (with uv) wired into gdbinit
# Usage: sudo bash kali-bootstrap.sh

set -euo pipefail
[[ $EUID -ne 0 ]] && { echo "Please run as root: sudo bash $0" >&2; exit 1; }

export DEBIAN_FRONTEND=noninteractive
export PIP_DISABLE_PIP_VERSION_CHECK=1
log(){ printf '\n[*] %s\n' "$*"; }

# ---------- APT BASELINE ----------
log "Updating apt & upgrading..."
apt-get update -y
apt-get upgrade -y

log "Installing core CLI & deps..."
apt-get install -y \
  build-essential git curl wget unzip zip xz-utils tar \
  ca-certificates software-properties-common pkg-config \
  jq ripgrep fzf tmux zsh vim neovim tree htop \
  net-tools iproute2 bind9-dnsutils whois nmap \
  iputils-ping traceroute telnet socat netcat-openbsd \
  python3 python3-pip python3-venv python3-dev \
  pipx virtualenv \
  gdb gdbserver strace ltrace patchelf binutils file \
  radare2 binwalk libimage-exiftool-perl foremost sleuthkit yara bulk-extractor \
  wireshark tshark \
  qemu-user-static qemu-system-x86 \
  php-cli chromium \
  libssl-dev libffi-dev zlib1g-dev libcapstone-dev libunicorn-dev

log "Installing web enum/fuzzing (apt)..."
# (httpx, git-dumper, xsstrike handled later)
apt-get install -y \
  ffuf gobuster dirsearch feroxbuster wfuzz \
  gitleaks amass sublist3r nuclei whatweb sqlmap \
  arjun seclists wordlists

# ---------- GO TOOLS ----------
log "Installing Golang & Go-based tools..."
apt-get install -y golang
if ! grep -q "GOPATH" /etc/profile; then
  cat >/etc/profile.d/go.sh <<'EOF'
export GOPATH=/opt/go
export GOBIN=/usr/local/bin
export PATH="$GOBIN:$GOPATH/bin:$PATH"
EOF
fi
export GOPATH=/opt/go
export GOBIN=/usr/local/bin
mkdir -p "$GOPATH"
go install github.com/projectdiscovery/httpx/cmd/httpx@latest || true
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest || true
go install github.com/tomnomnom/assetfinder@latest || true
go install github.com/hakluke/hakrawler@latest || true
go install github.com/tomnomnom/waybackurls@latest || true
go install github.com/tomnomnom/anew@latest || true
go install github.com/tomnomnom/httprobe@latest || true
go install github.com/lc/gau/v2/cmd/gau@latest || true

# ---------- PIPX APPS (CLIs only) ----------
log "Configuring pipx (PEP 668 safe) & installing CLI apps..."
if ! grep -q "PIPX_BIN_DIR" /etc/profile; then
  cat >/etc/profile.d/pipx.sh <<'EOF'
export PIPX_BIN_DIR=/usr/local/bin
export PIPX_HOME=/opt/pipx
export PATH="$PIPX_BIN_DIR:$PATH"
EOF
fi
export PIPX_BIN_DIR=/usr/local/bin
export PIPX_HOME=/opt/pipx
export PATH="$PIPX_BIN_DIR:$PATH"
mkdir -p /opt/pipx; chmod 755 /opt/pipx

pipx_iou(){ pipx install "$1" >/dev/null 2>&1 || pipx upgrade "$1" >/dev/null 2>&1 || true; }
pipx_iou pwntools
pipx_iou ROPgadget
pipx_iou ropper
pipx_iou volatility3
pipx_iou httpie
pipx_iou mitmproxy
pipx_iou git-dumper
pipx_iou trufflehog
pipx_iou uro
pipx install "git+https://github.com/GerbenJavado/LinkFinder.git" >/dev/null 2>&1 || true

# ---------- NON-APT TOOLS ----------
log "XSStrike via git clone + wrapper..."
if [[ ! -d /opt/XSStrike ]]; then
  git clone --depth=1 https://github.com/s0md3v/XSStrike /opt/XSStrike || \
  git clone --depth=1 https://github.com/0xInfection/XSStrike /opt/XSStrike || true
fi
cat >/usr/local/bin/xsstrike <<'EOF'
#!/usr/bin/env bash
exec python3 /opt/XSStrike/xsstrike.py "$@"
EOF
chmod +x /usr/local/bin/xsstrike

log "Ensure git-dumper exists (fallback clone if pipx missing app)..."
if ! command -v git-dumper >/dev/null 2>&1; then
  if [[ ! -d /opt/git-dumper ]]; then
    git clone --depth=1 https://github.com/arthaud/git-dumper /opt/git-dumper || true
  fi
  cat >/usr/local/bin/git-dumper <<'EOF'
#!/usr/bin/env bash
exec python3 /opt/git-dumper/git_dumper.py "$@"
EOF
  chmod +x /usr/local/bin/git-dumper
fi

# ---------- PWNDBG (with uv) ----------
log "Setting up pwndbg for GDB (installs uv if needed)..."
if [[ ! -d /opt/pwndbg ]]; then
  git clone --depth=1 https://github.com/pwndbg/pwndbg /opt/pwndbg
else
  (cd /opt/pwndbg && git pull --ff-only || true)
fi
if ! command -v uv >/dev/null 2>&1; then
  # install Astral uv for pwndbg setup (no -y flag)
  curl -LsSf https://astral.sh/uv/install.sh | sh
  install -m 0755 -D -t /usr/local/bin ~/.cargo/bin/uv || true
fi
( cd /opt/pwndbg && ./setup.sh --update || true )
grep -q "pwndbg" /root/.gdbinit 2>/dev/null || echo "source /opt/pwndbg/gdbinit.py" >> /root/.gdbinit
if [[ -n "${SUDO_USER:-}" ]]; then
  UHOME=$(eval echo ~"$SUDO_USER")
  grep -q "pwndbg" "$UHOME/.gdbinit" 2>/dev/null || { echo "source /opt/pwndbg/gdbinit.py" >> "$UHOME/.gdbinit"; chown "$SUDO_USER:$SUDO_USER" "$UHOME/.gdbinit"; }
fi

# ---------- WIRESHARK NON-ROOT ----------
log "Enabling non-root capture for Wireshark (safe if it fails)..."
groupadd -f wireshark || true
usermod -aG wireshark "${SUDO_USER:-$USER}" || true
dpkg-reconfigure wireshark-common || true
setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap || true

# ---------- PYTHON VENV FOR LIBS ----------
log "Creating /opt/ctf-venv and installing libraries..."
VENV_DIR=/opt/ctf-venv
python3 -m venv "$VENV_DIR"
"$VENV_DIR/bin/pip" install --upgrade pip
"$VENV_DIR/bin/pip" install \
  pwntools pycryptodome requests flask \
  angr z3-solver tqdm rich ipython jupyter \
  keystone-engine unicorn capstone

if ! grep -q "CTF_VENV" /etc/profile; then
  cat >/etc/profile.d/ctf-venv.sh <<EOF
export CTF_VENV="$VENV_DIR"
alias venv="source \$CTF_VENV/bin/activate"
EOF
fi

# ---------- PAYLOAD REPOS ----------
log "Pulling payload repos (idempotent)..."
if [[ ! -d /opt/PayloadsAllTheThings ]]; then
  git clone https://github.com/swisskyrepo/PayloadsAllTheThings /opt/PayloadsAllTheThings
else
  (cd /opt/PayloadsAllTheThings && git pull --ff-only || true)
fi
if [[ ! -d /opt/fuzzdb ]]; then
  git clone https://github.com/fuzzdb-project/fuzzdb /opt/fuzzdb
else
  (cd /opt/fuzzdb && git pull --ff-only || true)
fi

# ---------- SHELL QoL ----------
log "Adding shell QoL and ffuf aliases..."
if ! grep -q "alias ll=" /etc/bash.bashrc; then
  cat >> /etc/bash.bashrc <<'EOF'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias p3='python3'
alias pipup='echo "Use pipx or /opt/ctf-venv/bin/pip (PEP 668)"; false'

# SecLists convenience env
export SECLISTS=/usr/share/seclists

# Quick ffuf profiles (common)
alias ffuf-dir='ffuf -u http://TARGET/FUZZ -w $SECLISTS/Discovery/Web-Content/directory-list-2.3-medium.txt -recursion -recursion-depth 1 -t 150 -fc 403,404'
alias ffuf-ext='ffuf -u http://TARGET/indexFUZZ -w $SECLISTS/Discovery/Web-Content/web-extensions.txt -t 150 -fc 404'
EOF
fi

# ---------- HTML -> PDF HELPER ----------
log "Installing html2pdf helper (Chromium headless)..."
cat >/usr/local/bin/html2pdf <<'EOF'
#!/usr/bin/env bash
# Usage: html2pdf <input.html|URL> <output.pdf>
set -euo pipefail
IN="${1:?input html or URL required}"
OUT="${2:?output pdf path required}"
chromium --headless --disable-gpu --no-sandbox \
  --print-to-pdf="$OUT" "$IN"
echo "[✓] Wrote $OUT"
EOF
chmod +x /usr/local/bin/html2pdf

# ---------- RECONWRAP ----------
log "Installing reconwrap helper..."
cat >/usr/local/bin/reconwrap <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

usage(){ cat <<USG
reconwrap - opinionated web recon runner
Usage: reconwrap -d example.com [-o /path/to/out] [--nuclei-sev "medium,high,critical"] [--threads 150] [--rate 1000]
Defaults: OUT=~/recon_<domain>_<timestamp>, nuclei sev=medium,high,critical, ffuf threads=150
USG
exit 1; }

DOMAIN=""; OUT=""; NUCLEI_SEV="medium,high,critical"; THREADS=150; RATE=1000

while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--domain) DOMAIN="$2"; shift 2;;
    -o|--out) OUT="$2"; shift 2;;
    --nuclei-sev) NUCLEI_SEV="$2"; shift 2;;
    --threads) THREADS="$2"; shift 2;;
    --rate) RATE="$2"; shift 2;;
    -h|--help) usage;;
    *) echo "Unknown arg: $1"; usage;;
  esac
done

[[ -z "$DOMAIN" ]] && { echo "[!] -d/--domain is required"; usage; }
OUT="${OUT:-$HOME/recon_${DOMAIN}_$(date +%F_%H%M)}"
mkdir -p "$OUT"; echo "[*] Workspace: $OUT"

SECLISTS="${SECLISTS:-/usr/share/seclists}"

echo "[*] Subdomain enumeration..."
( assetfinder -subs-only "$DOMAIN" || true; subfinder -silent -d "$DOMAIN" || true ) | anew "$OUT/subs.txt" >/dev/null
echo "[+] subs: $(wc -l < "$OUT/subs.txt" 2>/dev/null || echo 0)"

echo "[*] Probing hosts with httpx..."
httpx -l "$OUT/subs.txt" -silent -td -ip -title -tech-detect -mc 200,301,302,401,403 -o "$OUT/live.txt" || true
awk '{print $1}' "$OUT/live.txt" | awk 'BEGIN{FS="://"} {print "http://"$2"\nhttps://"$2}' | anew "$OUT/hosts.txt" >/dev/null
echo "[+] live hosts: $(wc -l < "$OUT/hosts.txt" 2>/dev/null || echo 0)"

echo "[*] Checking common leak paths..."
printf '/.git/HEAD\n/.env\n/.DS_Store\n/backup.zip\n/.svn/entries\n' > "$OUT/leakpaths.txt"
while read -r url; do while read -r p; do echo "$url$p"; done < "$OUT/leakpaths.txt"; done < "$OUT/hosts.txt" \
  | httpx -silent -mc 200 -o "$OUT/leaks.txt" || true
GITHOSTS=$(awk -F' //' '/\.git\/HEAD/ {print $1}' "$OUT/leaks.txt" | sed 's#/$##' || true)
echo "[+] leaks: $(wc -l < "$OUT/leaks.txt" 2>/dev/null || echo 0)"
if [[ -n "${GITHOSTS}" ]]; then
  echo "[*] Dumping exposed .git repos..."
  while read -r u; do
    h=$(echo "$u" | sed -E 's#https?://##; s#[/:]#_#g')
    dst="$OUT/gitdump_$h"; mkdir -p "$dst"
    git-dumper "$u/.git/" "$dst" || true
    gitleaks detect -s "$dst" -r "$dst/gitleaks.json" --no-banner || true
  done <<< "$GITHOSTS"
fi

echo "[*] Crawling with hakrawler & pulling archives..."
hakrawler -plain -depth 2 -insecure -urls -scope subs -list "$OUT/hosts.txt" | anew "$OUT/urls_crawl.txt" >/dev/null || true
( waybackurls "$DOMAIN" || true; gau --subs "$DOMAIN" || true ) | anew "$OUT/urls_archive.txt" >/dev/null
cat "$OUT/urls_crawl.txt" "$OUT/urls_archive.txt" 2>/dev/null | sed 's/%2f/\//ig' | anew "$OUT/urls_all.txt" >/dev/null || true
grep -iE '\.js(\?|$)' "$OUT/urls_all.txt" | anew "$OUT/js_urls.txt" >/dev/null || true

echo "[*] Parameter discovery with arjun..."
arjun -i "$OUT/hosts.txt" -oT "$OUT/params.txt" >/dev/null 2>&1 || true

echo "[*] ffuf directory brute (CSV output)..."
ffuf -u http://FUZZ/ \
  -w "$SECLISTS/Discovery/Web-Content/directory-list-2.3-medium.txt" \
  -w "$OUT/subs.txt" -H "Host: FUZZ.$DOMAIN" \
  -of csv -o "$OUT/ffuf_dirs.csv" -t "$THREADS" -rate "$RATE" \
  -mc 200,204,301,302,307,401,403 -fc 404 -H "User-Agent: reconwrap/1.0" -v || true

echo "[*] nuclei templating..."
nuclei -l "$OUT/hosts.txt" -severity "$NUCLEI_SEV" -silent -o "$OUT/nuclei.txt" -rl 50 || true

echo "----- SUMMARY -----" | tee "$OUT/SUMMARY.txt"
for f in subs.txt live.txt hosts.txt leaks.txt urls_all.txt js_urls.txt params.txt nuclei.txt ffuf_dirs.csv; do
  [[ -s "$OUT/$f" ]] && printf '%-16s %7d\n' "$f" "$(wc -l < "$OUT/$f" 2>/dev/null || echo 0)" | tee -a "$OUT/SUMMARY.txt"
done
echo "[✓] Done -> $OUT"
EOF
chmod +x /usr/local/bin/reconwrap

# ---------- MOTD ----------
log "Writing quick notes to /etc/motd..."
cat >/etc/motd <<'MOTD'
CTF Bootstrap Quick Notes
-------------------------
Venv:      source /opt/ctf-venv/bin/activate   (or: venv)
ffuf dir:  ffuf -u http://HOST/FUZZ -w $SECLISTS/Discovery/Web-Content/directory-list-2.3-medium.txt -t 150 -fc 403,404
.git dump: git-dumper http://HOST/.git/ /tmp/dump && cd /tmp/dump && git fsck --lost-found
Recon:
  assetfinder -subs-only example.com | anew subs.txt
  subfinder -d example.com -silent   | anew subs.txt
  httpx -l subs.txt -mc 200,302 -td -ip -title -tech-detect -o live.txt
Crawling:
  hakrawler -url https://example.com -plain -depth 2 | anew urls.txt
Archive:
  waybackurls example.com | anew urls.txt
MOTD

# ---------- SUBLIME TEXT ----------
log "Adding Sublime Text repo & installing Sublime..."
install -d -m 0755 /etc/apt/keyrings
if [[ ! -s /etc/apt/keyrings/sublimehq-pub.asc ]]; then
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | tee /etc/apt/keyrings/sublimehq-pub.asc >/dev/null
fi
if [[ ! -s /etc/apt/sources.list.d/sublime-text.sources ]]; then
  cat >/etc/apt/sources.list.d/sublime-text.sources <<'EOF'
Types: deb
URIs: https://download.sublimetext.com/
Suites: apt/stable/
Signed-By: /etc/apt/keyrings/sublimehq-pub.asc
EOF
fi
apt-get update -y
apt-get install -y sublime-text

# ---------- CLEANUP ----------
log "Cleaning apt caches..."
apt-get autoremove -y
apt-get clean

echo
echo "[✓] All done."
echo "   - New terminal = fresh PATH/group (wireshark) + profile scripts."
echo "   - Use 'venv' to activate /opt/ctf-venv (libs: keystone/unicorn/capstone)."
echo "   - Tools in /usr/local/bin (httpx, subfinder, reconwrap, html2pdf, etc)."
