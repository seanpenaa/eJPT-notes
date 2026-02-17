# NMAP
## Enumerate TCP ports
```
nmap -p$(nmap -p- --min-rate=1000 -T4 $TARGET | grep '^[0-9]' | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//) -sV -Pn $TARGET -oA ${TARGET}
```

## FTP (port 21):
```
nmap -Pn -sV -p 21 --script="banner,(ftp* or ssl*) and not (brute or broadcast or dos or external or fuzzer)" -oX "${TARGET}_ftp_nmap.xml" $TARGET
```

## SSH (port 22):
```
nmap -Pn -sV -p 22 --script="banner,ssh2-enum-algos,ssh-hostkey,ssh-auth-methods" -oX ${TARGET}_ssh_nmap.xml $TARGET
```

## SMTP (port 23):
```
nmap -Pn -sV -p 25 "--script=banner,(smtp* or ssl*) and not (brute or broadcast or dos or external or fuzzer)" -oX ${TARGET}_smtp_nmap.xml $TARGET
```

## DNS (port 53):
```
sudo nmap -Pn -sU -sV -p 53 "--script=banner,(dns* or ssl*) and not (brute or broadcast or dos or external or fuzzer)" -oN ${TARGET}_dns_nmap.txt $TARGET
```

## HTTP/HTTPS (port 80,443):
```
# Version detection + NSE scripts
nmap -Pn -sV -p 80 "--script=banner,(http* or ssl*) and not (brute or broadcast or dos or external or http-slowloris* or fuzzer)" -oA ${TARGET}_http_script $TARGET
```

## SMB (port 139,445)
```
nmap -Pn -sV -p 111 "--script=banner,(nfs* or ssl*) and not (brute or broadcast or dos or external or fuzzer)" --script-args=unsafe=1 -oA ${TARGET}_nfs_nmap. $TARGET
```

## SMB (port 139,445)
```
nmap -Pn -sV -p 139,445 "--script=banner,(nbstat* or smb* or ssl*) and not (brute or broadcast or dos or external or fuzzer)" --script-args=unsafe=1 -oA ${TARGET}_smb_nmap $TARGET
```

Scan for common vulnerabilities:
```
# RRAS Service Overflow
nmap -Pn -sV -p 445 --script="smb-vuln-ms06-025" --script-args="unsafe=1" -oN "tcp_445_smb_ms06-025.txt" $TARGET

# DNS RPC Service Overflow
nmap -Pn -sV -p 445 --script="smb-vuln-ms07-029" --script-args="unsafe=1" -oN "tcp_445_smb_ms07-029.txt" $TARGET

# Server Service Vulnerability
nmap -Pn -sV -p 445 --script="smb-vuln-ms08-067" --script-args="unsafe=1" -oN "tcp_445_smb_ms08-067.txt" $TARGET

# Eternalblue  
nmap -p 445 --script smb-vuln-ms17-010 -oN "tcp_445_smb_ms17-010.txt" $TARGET
```

## SQL (port 3306)
```
# Version detection + NSE scripts
nmap -Pn -sV -p 3306 --script="banner,(mysql* or ssl*) and not (brute or broadcast or dos or external or fuzzer)" -oA "${TARGET}_mysql_nmap" $TARGET
```

## IDS/Firewall Evasion
<span style="color: #ffcd7f">nmap</span> has a <span style="color: #ffcd7f">section for all Firewall/IDS</span> evasion and spoofing <span style="color: #ffcd7f">in its man page</span>
```
# nmap ACK scan
# Can be used if port traffic is filtered by a firewall
nmap -sA 
```
using -f to <span style="color: #ffcd7f">fragment packets</span>
```
nmap -Pn -sS -f <ip>
```
using --mtu to <span style="color: #ffcd7f">specify minimum transfer units</span>
```
nmap -Pn -sS -F --mtu <mtu amount#> <ip>
```
using -D to <span style="color: #ffcd7f">spoof source IP</span>
```
nmap -Pn -sS -f -D <IP to spoof as>,<2nd IP to spoof as> <ip>
# Example scan of 192.168.0.0/24 spoofed as 192.168.0.1 
nmap -Pn -sS -f -D 192.168.0.1 192.168.0.0/24
```
--scan-delay to avoid frequency detection
```
nmap -sS -sV -F --scan-delay <##s> <ip>
```
