#!/bin/sh
# file: updatedata.sh
#
#
defaults()
{
    h=$HOME
    basedir=$HOME
    gitdir=$basedir/git
    repo="https://github.com/cimichaelm/aidevbootstrap.git"
    branch="develop"
    workdir=$gitdir/h2ogpt
}

update_data()
{
    if [ -d $workdir ]; then
	cd $workdir
	docker run \
	       --gpus all \
	       --shm-size=2g \
	       --rm --init \
	       --network host \
	       -v /etc/passwd:/etc/passwd:ro \
	       -v /etc/group:/etc/group:ro \
	       -u `id -u`:`id -g` \
	       -v "${HOME}"/.cache:/workspace/.cache \
	       -v "${HOME}"/save:/workspace/save \
	       -v ./user_path:/workspace/user_path \
	       -v ./db_dir_UserData:/workspace/db_dir_UserData \
	       gcr.io/vorvan/h2oai/h2ogpt-runtime:0.1.0 /workspace/src/make_db.py

    fi


}

defaults

update_data

exit 0
