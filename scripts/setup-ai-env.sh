#!/bin/sh
# file: setup-ai-env.sh
#
#
defaults()
{
    h=$HOME
    instdirflags="-d -m 755 -o ${u} -g ${u}"
    venv="py3env03"
    requirements="conf/requirements.txt"
    popopts=""
    basedir=$HOME
    gitdir=$basedir/git
    workdir=$gitdir/h2ogpt
    repo="https://github.com/h2oai/h2ogpt.git"
    logfile=$h/log
    logfile=$logdir/setup.log
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
	source $HOME/$venv/bin/activate
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
    sudo apt-get update -y
    sudo apt-get install -y aptitude
    sudo aptitude update -y
    sudo aptitude upgrade -y
    sudo aptitude install -y python3-pip python3-venv net-tools nginx
}

	
setup_work()
{
    cd $gitdir
    git clone $repo
    pip install -r requirements.txt
    pip install -r reqs_optional/requirements_optional_langchain.txt
    pip install -r reqs_optional/requirements_optional_gpt4all.txt
    
}

defaults

setup_pkgs

setup_python_venv
setup_python $requirements

setup_dirs
setup_git_dirs

setup_work | tee $logfile








