#!/bin/sh
# file: setup-ai-env.sh
#
#
defaults()
{
    h=$HOME
    bindir=$HOME/bin
    instdirflags="-d -m 755"
    venv="py3env03"
    requirements="conf/requirements.txt"
    pipopts=""
    basedir=$HOME
    gitdir=$basedir/git
    workdir=$gitdir/h2ogpt
    repo="https://github.com/h2oai/h2ogpt.git"
    logdir=$h/log
    logfile=$logdir/setup.log
    remoteuser="ubuntu"
    pkglist="apt-transport-https ca-certificates curl software-properties-common python3-pip python3-venv net-tools nvidia-container-toolkit-base nvidia-container-runtime"
    pkglist2="nginx"
}

setup_dirs()
{
    install ${instdirflags} $logdir
}

setup_git_dirs()
{
    install ${instdirflags} $gitdir
}


setup_python_venv()
{
    if [ ! -d $HOME/$venv ]; then
	python3 -m venv $HOME/$venv
    fi
}

enable_python_venv()
{
    if [ -d $HOME/$venv ]; then
	. $HOME/$venv/bin/activate
    fi
}

setup_python()
{

    Lrequirements=$1

    if [ -f $Lrequirements ]; then
	pip install $pipopts -r $Lrequirements
    fi
}

setup_pkgs()
{
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get update -y
    sudo apt-get install -y aptitude
    sudo aptitude update -y
    sudo aptitude upgrade -y
    sudo aptitude install -y $pkglist
    sudo apt autoremove -y
    sudo systemctl disable nginx
    sudo systemctl stop nginx
}

setup_system()
{
    sudo usermod -a -G docker $remoteuser

    #newgrp docker
}

	
run_setup_work()
{
    $bindir/setup-work.sh
}

reload_bashrc()
{
    . $HOME/.bashrc
}

run_setup_conda()
{
    $bindir/setup-conda.sh
}

defaults

setup_pkgs
setup_system

run_setup_conda

setup_python_venv
#setup_python $requirements


run_setup_work

exit 0
