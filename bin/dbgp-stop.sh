#!/bin/bash
if [[ ! -f dbgp.pid ]]; then
    cat ./dbgp.pid | xargs kill
    rm -f ./dbgp.pid
fi