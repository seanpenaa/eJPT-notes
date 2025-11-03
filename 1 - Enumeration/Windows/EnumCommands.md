### Windows Defender Status
```
Get-MpComputerStatus
```

### List AppLocker Rules
```
Get-AppLockerPolicy -Effective | select -ExpandProperty RuleCollections
```

### tasklist
```
tasklist /svc
```

### Environment Variables
```
set
```

### Detailed Configuration Information
```
systeminfo
```

### Patches and Updates
```
wmic qfe

Get-HotFix | ft -AutoSize
```

### Installed Programs
```
wmic product get name

Get-WmiObject -Class Win32_Product | select Name, Version
```

### Users
```
query user

echo %USERNAME

whoami /priv
whoami /groups
net user
net localgroup
net localgroup administrators
net accounts

```


