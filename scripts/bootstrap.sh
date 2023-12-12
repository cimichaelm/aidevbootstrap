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
    if [ ! -d $gitdir ]; then
	mkdir $gitdir
    fi
    cd $gitdir

    if [ ! -d aidevbootstrap ]; then
	git clone https://github.com/cimichaelm/aidevbootstrap.git
    fi
    cd aidevbootstrap
    git checkout $branch
    make install
}

defaults

run_bootstrap

exit 0
