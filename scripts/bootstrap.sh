#!/bin/sh
# file: bootstrap.sh
#
#
defaults()
{
    h=$HOME
    basedir=$HOME
    gitdir=$basedir/git
    repo="https://github.com/cimichaelm/aidevbootstrap.git"
}


run_bootstrap()
{
    mkdir $gitdir
    cd $gitdir

    git clone https://github.com/cimichaelm/aidevbootstrap.git
    cd audevbootstrap
    make install
}

defaults

run_bootstrap

exit 0
