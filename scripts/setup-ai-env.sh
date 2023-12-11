#!/bin/sh
# file: setup-ai-env.sh
#
#
defaults()
{
    h=$HOME
    bindir=$HOME/bin
    instdirflags="-d -m 755 -o ${u} -g ${u}"
    venv="py3env03"
    requirements="conf/requirements.txt"
    popopts=""
    basedir=$HOME
    gitdir=$basedir/git
    workdir=$gitdir/h2ogpt
    repo="https://github.com/h2oai/h2ogpt.git"
    logdir=$h/log
    logfile=$logdir/setup.log
    remoteuser="ubuntu"
    pkglist="apt-transport-https ca-certificates curl software-properties-common python3-pip python3-venv net-tools nginx nvidia-container-toolkit-base nvidia-container-runtime"
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
}

setup_system()
{
    sudo usermod -a -G docker $remoteuser

    #newgrp docker
}

	
setup_work()
{
    cd $gitdir
    if [ ! -d $workdir ]; then
	git clone $repo
    fi
    if [ -d $workdir ]; then
	cd $workdir

	conda activate py3k
	
	pip install librosa
	
	export PIP_EXTRA_INDEX_URL="https://download.pytorch.org/whl/cu118"	
	pip install -r requirements.txt
	pip install -r reqs_optional/requirements_optional_langchain.txt
	pip install -r reqs_optional/requirements_optional_gpt4all.txt

	# Only Linux:
	pip install https://github.com/jllllll/llama-cpp-python-cuBLAS-wheels/releases/download/textgen-webui/llama_cpp_python_cuda-0.2.19+cu118-cp310-cp310-manylinux_2_31_x86_64.whl

    fi
    
}

setup_miniconda()
{
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf ~/miniconda3/miniconda.sh
    ~/miniconda3/bin/conda init bash
    ~/miniconda3/bin/conda init zsh

    conda create -n py3k anaconda python=3

conda activate py3k
}

defaults

setup_pkgs
setup_system

setup_miniconda

setup_python_venv
#setup_python $requirements

setup_dirs
setup_git_dirs

setup_work | tee $logfile

exit 0
