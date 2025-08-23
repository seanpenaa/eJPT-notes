## Default scan:
```
feroxbuster -u http://target.com
```

## Quiet mode:
```
feroxbuster -u http://target.com -q
```

## Recuresive & Depth:
```
feroxbuster -u http://target.com -r
feroxbuster -u http://target.com -r -D 6
```

## Wordlist & Multi-wordlist:
```
feroxbuster -u http://target.com -w /usr/share/wordlists/dirb/common.txt
feroxbuster -u http://target.com -w list1.txt -w list2.txt
```

## Multiple Hosts:
```
feroxbuster -u http://10.10.10.10 -u http://10.10.10.11
feroxbuster -u http://10.10.10.0/24
```

## Filters:
```
Status code -
feroxbuster -u http://target.com -s 200 403
Exempt status code -
feroxbuster -u http://target.com -x 404
Response size -
feroxbuster -u http://target.com --filter-size 0
Response words -
feroxbuster -u http://target.com --filter-words 10
Response lines -
feroxbuster -u http://target.com --filter-lines 20
```

## Extensions:
```
feroxbuster -u http://target.com -x php -x txt -x bak -x zip
feroxbuster -u http://target.com --extensions-file extensions.txt
```

## Auth & Headers:
```
feroxbuster -u http://target.com -A user:pass
feroxbuster -u http://target.com -H "Authorization: Bearer <token>"
feroxbuster -u http://target.com -H "Cookie: sessionid=abcd1234"
feroxbuster -u http://target.com -H "User-Agent: CTF-Scanner"
feroxbuster -u http://target.com -H "Cookie: a=1" -H "X-Forwarded-For: 127.0.0.1"
```

## Speed:
```
feroxbuster -u http://target.com -t 50
feroxbuster -u http://target.com --rate-limit 50
feroxbuster -u http://target.com --timeout 5
```

## Output to file:
```
feroxbuster -u http://target.com -o results.txt
feroxbuster -u http://target.com -o results.json -O json
feroxbuster -u http://target.com -o results.txt --append-output
```

## Random agent:
```
feroxbuster -u http://target.com --random-agent
```

## .git repos:
```
feroxbuster -u http://target.com -x git -x bak -x old -x tar -x zip
```

