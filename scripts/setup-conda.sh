#!/bin/bash
# file: setup-conda.sh
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


reload_bashrc()
{
    . $HOME/.bashrc
}

setup_miniconda()
{
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh
    ~/miniconda3/bin/conda init bash
    ~/miniconda3/bin/conda init zsh

    reload_bashrc
    
    bash -c conda create -n py3k anaconda python=3 -y

    conda activate py3k
}

defaults


setup_miniconda

exit 0
