#!/bin/sh
# file: build.sh
#
#
defaults()
{
    h=$HOME
    logdir=$h/log
    logfile=$logdir/setup.log
    bindir=$HOME/bin
}

run_build()
{
    $bindir/setup-ai-env.sh
}

defaults


run_build | tee $logfile

exit 0
