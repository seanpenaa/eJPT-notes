Find the offset using the tool immunity debugger

```
kali> /usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l <python script output>
```

Change the python script variable "buffer" to the output of this command

```
kali> /usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l <python script output> -q <EIP output>
```