#set env vars
set -o allexport; source .env; set +o allexport;

cat << EOT >> ./.env

GOTENBERG_URL=http://gotenberg:3000
GOTENBERG_DOCS_URL=http://server:3000/public/
EOT