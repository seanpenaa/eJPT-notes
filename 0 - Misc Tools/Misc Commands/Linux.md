# tmux
Terminal multiplexer
```
tmux
```

Shortcuts:
Ctrl + B + C = Create a new terminal session
Ctrl + B + # = Switch to terminal session
`exit` = Closes terminal session
ctrl b + w    # show windows
ctrl + "      # split window horizontal
ctrl + %      # split window vertical
ctrl + ,      # rename window
ctrl + {      # flip window
ctrl + }      # flip window
ctrl + spacebar    # switch pane layout

Copy and Paste:
```
:setw -g mode-keys vi
ctrl b + [
space
enter
ctrl b + ]
```

Save output:
```
ctrl b + :
capture-pane -S -
ctrl b + :
save-buffer <FILE>.txt
```