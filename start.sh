#!/bin/sh
cd /mediadrop
source mediacore_env/bin/activate

paster make-config MediaDrop deployment.ini

# Prepare DB Connection String
sed -i "s/username:pass@localhost\/dbname/${DB_USER}:${DB_PASSWORD}@${DB_HOST}\/${DB_NAME}/g" deployment.ini

sed -i "s/cache_dir = %(here)s\/data/cache_dir = \/data/g" deployment.ini
sed -i "s/image_dir = %(here)s\/data\/images/image_dir = \/data\/images/g" deployment.ini
sed -i "s/media_dir = %(here)s\/data\/media/media_dir = \/data\/media/g" deployment.ini

# Copy persistent data to volume
if [ ! -f /data/.initialized ]; then
   cp -r /mediadrop/data/* /data/
fi

# Initialize app params & files
paster setup-app /mediadrop/deployment.ini

if [ ! -f /data/.initialized ]; then
   mysql -u"$DB_USER" -p"$DB_PASSWORD" --host="$DB_HOST" $DB_NAME < /mediadrop/setup_triggers.sql
fi
touch /data/.initialized

paster serve --reload /mediadrop/deployment.ini