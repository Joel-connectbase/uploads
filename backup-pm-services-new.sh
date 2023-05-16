process_name="Backup"
timestamp=$(date +%Y-%m-%d)\
snapshot_file="$process_name-$timestamp.pm2"

# Save PM2 backup
pm2 save --name "$process_name-$timestamp"

# # create another file if snapshot file already exists
# if [ -f "$snapshot_file" ]; then
#   i=1
#   while [ -f "$process_name-$timestamp-$i.tar.gz" ]; do
#     ((i++))
#   done
#   snapshot_file="$process_name-$timestamp-$i.tar.gz"
# fi

# Create snapshot file
tar -czvf "$snapshot_file" ~/.pm2/dump/"$process_name-$timestamp.pm2"

#copy files to blob
#azcopy cp "~/.pm2/dump/"$process_name*.pm2" "https://tcwstage.blob.core.windows.net/c2f-files/$process_name-$timestamp.pm2"

# upload files to blob storage
az storage blob upload -f ~/.pm2/dump/"$process_name-$timestamp.pm2 -c backup -n back --account-name tcwstage --auth-mode login