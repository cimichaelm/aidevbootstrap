#!/bin/sh
# file: ai-run.sh
#
#
defaults()
{
    h=$HOME
    venv="py3env03"
    requirements="conf/requirements.txt"
    popopts=""
    basedir=$HOME
    gitdir=$basedir/git
    workdir=$gitdir/h2ogpt
    repo="https://github.com/h2oai/h2ogpt.git"
    logdir=$h/log
    logfile=$logdir/setup.log
}

load_python_venv()
{
    if [ -d $HOME/$venv ]; then
	source $HOME/$venv/bin/activate
    fi
}

run_app()
{
    if [ -d $workdir ]; then
	cd $workdir
	python generate.py --base_model=llama --prompt_type=llama2 --model_path_llama=https://huggingface.co/TheBloke/Llama-2-7b-Chat-GGUF/resolve/main/llama-2-7b-chat.Q6_K.gguf --max_seq_len=4096
    fi
    
}

defaults

load_python_venv

run_app
