#!/bin/sh
status=$( (tarantool <<-'EOF'
local CONSOLE_SOCKET_PATH = 'unix/:/var/run/tarantool/tarantool.sock'
local console = require('console')
local os = require("os")
console.on_start(function(self)
    local status, reason
    status, reason = pcall(function() require('console').connect(CONSOLE_SOCKET_PATH) end)
    if not status then
        self:print(reason)
        os.exit(1)
    end
    cmd = 'app.reload()'
    self:eval(cmd)
    print('app reloaded')
    os.exit(0)
end)
console.on_client_disconnect(function(self) self.running = false end)
console.start()
os.exit(0)
EOF
​) 2>/dev/null)

echo "$status"

if [ "$status" = "app reloaded" ]; then
    exit 0
else
    exit 1
fi
