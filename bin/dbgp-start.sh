#!/bin/bash
if [[ ! -f dbgp.pid ]]; then
    nohup php ./xdebug-proxy > /dev/null 2>&1 < /dev/null &
    echo $! > dbgp.pid
fi
