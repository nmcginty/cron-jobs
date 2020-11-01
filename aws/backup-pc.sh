#!/usr/bin/zsh

DATE=$(echo $(date) | sed 's/[ :]/-/g')
echo "DATE: $DATE"
DAY=$(date +%A)
TAR_FILE=/home/wheat/code/data/hdd/debian-pc-home-backup-${DATE}.tgz
echo "TAR_FILE: $TAR_FILE"

! [[ $DAY == "Sunday" ]]
DAY_IS_SUNDAY=$?

# Run full backups only on Sunday
if (( $DAY_IS_SUNDAY ));then
	tar --exclude=/home/wheat/code/data \
		-cvzf \
		${TAR_FILE} \
	    /home/wheat	
else
	tar --exclude=/home/wheat/code/data/hdd \
		--exclude=/home/wheat/aws \
		--exclude-vcs \
		--exclude=node_modules \
		--exclude=.venv \
		--exclude=.config \
		--exclude=.phoronix-test-suite \
		--exclude=.cache \
		--exclude=.local \
		--exclude=.java \
		--exclude=.zoom \
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
		-cvzf \
		${TAR_FILE} \
	    /home/wheat	
fi

backup_successful=$?
AWS_S3_BACKUPS_BUCKET_NAME=wheat-pc-backups

if [[ $backup_successful -eq 0 ]]; then 
	aws s3 cp ${TAR_FILE} s3://${AWS_S3_BACKUPS_BUCKET_NAME} --region us-east-1 --storage-class STANDARD_IA
    # TODO check if copy was successful, may be able to handle this via aws
	exit 0
fi

exit 1

