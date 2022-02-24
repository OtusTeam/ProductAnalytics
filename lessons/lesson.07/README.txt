docker run -d \
  -p 3306:3306 \
  --name some-mariadb \
  --env MARIADB_DATABASE=blog_app \
  --env MARIADB_USER=example-user \
  --env MARIADB_PASSWORD=my_cool_secret \
  --env MARIADB_ROOT_PASSWORD=my-secret-pw \
  mariadb:latest

docker start some-mariadb

docker stop some-mariadb
docker rm some-mariadb
