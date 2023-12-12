#!/bin/sh
# file: savedata.sh
#
#
defaults()
{
    h=$HOME
    basedir=$HOME
    gitdir=$basedir/git
    workdir=$gitdir/h2ogpt
    datadir=$HOME/shareddata01
    archivefile=$HOME/archive.tgz
    filelist=".env docker-compose2.yml user_path db_dir_UserData"
}

save_data()
{
    if [ -d $workdir ]; then
	cd $workdir
	tar czf $archivefile $filelist
    else
	echo "ERROR: $workdir does not exist"
    fi


}

restore_data()
{
    if [ -d $workdir ]; then
	cd $workdir
	tar xvzf $archivefile
    else
	echo "ERROR: $workdir does not exist"
    fi


}

defaults

save_data
#restore_data

exit 0
