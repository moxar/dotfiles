# Import a mysql dump
function mim
 set name (basename $argv | sed 's/\.[^.]*$//')
 #set name (uuidgen | sed 's/-//g')
 docker-compose exec -T mysql mysql -u root --password=rootpass -e "CREATE DATABASE $name;"
 cat $argv | sed 's/DEFINER=[^*]*\*/\*/g' | docker-compose exec -T mysql mysql -u root --password=rootpass $name
end
