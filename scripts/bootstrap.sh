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
    branch="develop"
}


run_bootstrap()
{
    mkdir $gitdir
    cd $gitdir

    git clone https://github.com/cimichaelm/aidevbootstrap.git
    cd audevbootstrap
    git checkout $branch
    make install
}

defaults

run_bootstrap

exit 0
