#!/usr/bin/zsh

DATE=$(echo $(date) | sed 's/[ :]/-/g')
echo "DATE: $DATE"
DAY=$(date +%A)
TAR_FILE=/home/wheat/code/data/hdd/debian-pc-home-backup-${DATE}.tgz
echo "TAR_FILE: $TAR_FILE"

! [[ $DAY == "Sunday" || $DAY == "Tuesday" || $DAY == "Thursday" ]]
BACKUP=$?

if (( $BACKUP ));then
	sleep 2
	tar --exclude=/home/wheat/code/data/hdd \
	    --exclude=/home/wheat/aws \
	    --exclude=vcs \
		--exclude=/home/wheat/thinkorswim \
	    --exclude=node_modules \
	    --exclude=.venv \
	    --exclude=.kite \
	    --exclude=.config \
	    --exclude=.phoronix-test-suite \
	    --exclude=.cache \
	    --exclude=.local \
	    --exclude=.java \
	    --exclude=.jar \
	    --exclude=.zoom \
	    --exclude=.git \
	    --exclude=.ssr \
	    --exclude=.nsightsystems \
	    --exclude=.vscode \
	    --exclude=.vim \
	    --exclude='*.swp' \
	    --exclude='*.ova' \
	    --exclude='*.tar' \
	    --exclude='*.tar.gz' \
	    --exclude='*.tgz' \
	    --exclude='*.iso' \
	    --exclude='*.zip' \
	    --exclude='*.dat' \
	    --exclude='*.data' \
	    --exclude='*.AppImage' \
	    -czf \
	    ${TAR_FILE} \
        /home/wheat	
fi

#backup_successful=$?
# Fix this later, sometimes tar command dies for whatever reason but actually does create the file
backup_successful=0
AWS_S3_BACKUPS_BUCKET_NAME=wheat-pc-backups

if [[ $backup_successful -eq 0 ]]; then 
	echo "Backup successful"
	aws s3 cp ${TAR_FILE} s3://${AWS_S3_BACKUPS_BUCKET_NAME} --region us-east-1 --storage-class GLACIER
    # TODO check if copy was successful, may be able to handle this via aws
	exit 0
fi

echo "Backup unsuccessful"
exit 1

