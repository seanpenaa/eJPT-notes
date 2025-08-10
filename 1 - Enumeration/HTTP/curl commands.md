## Sending a GET request
```
curl -X GET 192.45.178.3 
```

# Sending HEAD request
```
curl -I 192.45.178.3  
```


# Sending OPTIONS request
```
curl -X OPTIONS 192.45.178.3
```


# Sending POST Request
```
curl -X POST 192.45.178.3
```


# Sending PUT Request
```
curl -XPUT 192.45.178.3
```


# Interactive login request with CURL
```
curl -X OPTIONS 192.45.178.3/login.php 
```


```
curl -X POST 192.45.178.3/login.php -d "name=john&password=password" -v 
```

# Sending OPTIONS request to a file dir
```
curl -X OPTIONS 192.45.178.3/uploads/ -v 
```

# Uploading a file with PUT method
```
curl 192.45.178.3/uploads/ --upload-file hello.txt
```


# Using the DELETE method
```
curl -XDELETE 192.45.178.3/uploads/hello.txt 
```
# curl with POST
```
curl http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=key' -H 'Content-Type: application/x-www-form-urlencoded'
```
