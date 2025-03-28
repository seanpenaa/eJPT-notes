Enumerate banner and server:
```
nmap -sV -script banner <ip>
```

Connect using nc:
```
nc <ip> <smtp port>
```

Connect using telnet:
```
telnet <ip> <smtp port>
```

Verify if user exists:
```
VRFY <user>@<domain>
```

Enumerate commands using telnet:
```
telnet <ip> <smtp port>
HELO <target domain>
EHLO <target domain>
```

Send an email while connected through telnet:
```
HELO <domain>
mail from: <user>@<domain>
rcpt to: <targetuser>@<domain>
data
Subject: <Subject>

<Body>

.
```
Period indicates the end of the message

Send an email using sendemail command in shell:
```
sendemail -f <user>@<domain> -t <target user>@<domain> -s <smtp server> -u <user> -m <message> -o tls=no 
```