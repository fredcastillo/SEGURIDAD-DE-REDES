#!/bin/bash
set -e

DB_DIR="$HOME/lab-images/db"
mkdir -p "$DB_DIR"

cat > "$DB_DIR/Dockerfile" <<'DOCKER'
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y mariadb-server iproute2 net-tools iputils-ping && apt clean

RUN service mariadb start && \
    mysql -e "CREATE DATABASE labdb; \
    CREATE TABLE labdb.users (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT INTO labdb.users VALUES (1,'alice'),(2,'bob'); \
    CREATE USER 'webuser'@'10.21.75.130' IDENTIFIED BY 'Lab#2175'; \
    GRANT SELECT ON labdb.* TO 'webuser'@'10.21.75.130'; \
    FLUSH PRIVILEGES;" && \
    sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf && \
    service mariadb stop && \
    rm -f /var/run/mysqld/mysqld.pid /var/run/mysqld/mysqld.sock

ENV IP_ADDR=10.21.75.146
ENV PREFIX=28
ENV GATEWAY=10.21.75.145

COPY start-network.sh /start-network.sh
RUN chmod +x /start-network.sh
CMD ["/start-network.sh"]
DOCKER

cat > "$DB_DIR/start-network.sh" <<'SCRIPT'
#!/bin/bash
exec > /var/log/start-network.log 2>&1
set -e

IP_ADDR="${IP_ADDR:-10.21.75.146}"
PREFIX="${PREFIX:-28}"
GATEWAY="${GATEWAY:-10.21.75.145}"

for i in $(seq 1 15); do
  ip link show eth0 >/dev/null 2>&1 && break
  sleep 1
done

ip addr flush dev eth0
ip addr add ${IP_ADDR}/${PREFIX} dev eth0
ip link set eth0 up
ip route replace default via ${GATEWAY}

rm -f /var/run/mysqld/mysqld.pid /var/run/mysqld/mysqld.sock
service mariadb start
tail -F /var/log/mysql/error.log
SCRIPT
chmod +x "$DB_DIR/start-network.sh"

docker build -t db-server-lab "$DB_DIR"
