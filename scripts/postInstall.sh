#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 140s;


target=$(docker-compose port nginx 80)


curl http://${target}/api/auth/register \
  -H 'accept: application/json, text/plain, */*' \
  -H 'accept-language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7,he;q=0.6' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'pragma: no-cache' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36' \
  --data-raw '{"first_name":"admin","last_name":"admin","email":"'${ADMIN_EMAIL}'","password":"'${ADMIN_PASSWORD}'"}' \
  --compressed

  sleep 30s;

  docker-compose exec -T mysql bash -c "mysql -u root -p'${DB_ROOT_PASSWORD}' -e \"USE bigcapital_system; ALTER TABLE USERS MODIFY verified tinyint(1) DEFAULT true;\""
