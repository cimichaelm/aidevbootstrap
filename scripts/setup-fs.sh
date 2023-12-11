#!/bin/sh
# file: setup-fs.sh
#
#
defaults()
{
    h=$HOME
    bindir=$HOME/bin
    instdirflags="-d -m 755"
    venv="py3env03"
    basedir=$HOME
    gitdir=$basedir/git
    workdir=$gitdir/h2ogpt
    logdir=$h/log
    logfile=$logdir/setup.log
}

setup_dirs()
{
    install ${instdirflags} $logdir
    install ${instdirflags} $bindir    
}

setup_git_dirs()
{
    install ${instdirflags} $gitdir
}



defaults

setup_dirs
setup_git_dirs

exit 0
