#!/bin/bash
set -e

DIR="$HOME/lab-images/browser-vnc"
mkdir -p "$DIR"

cat > "$DIR/Dockerfile" <<'DOCKER'
FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y firefox-esr iproute2 net-tools iputils-ping && apt clean

ENV IP_ADDR=10.21.75.110
ENV PREFIX=25
ENV GATEWAY=10.21.75.1

COPY start-network.sh /start-network.sh
RUN chmod +x /start-network.sh
CMD ["/start-network.sh"]
DOCKER

cat > "$DIR/start-network.sh" <<'SCRIPT'
#!/bin/bash
exec > /var/log/start-network.log 2>&1
set -e

IP_ADDR="${IP_ADDR:-10.21.75.110}"
PREFIX="${PREFIX:-25}"
GATEWAY="${GATEWAY:-10.21.75.1}"

for i in $(seq 1 15); do
  ip link show eth0 >/dev/null 2>&1 && break
  sleep 1
done

ip addr flush dev eth0
ip addr add ${IP_ADDR}/${PREFIX} dev eth0
ip link set eth0 up
ip route replace default via ${GATEWAY}

exec firefox-esr --no-remote --new-instance
SCRIPT
chmod +x "$DIR/start-network.sh"

docker build -t browser-gns3vnc-lab "$DIR"
