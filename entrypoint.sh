#!/usr/bin/env bash

[ -n "${CloudID}" ] && [ -n "${HTTPDZ}" ]
sed -i "s#CloudID#${CloudID}#g;s#HTTPDZ#${HTTPDZ}#g" config.yml
#sed -i "s#VMESS_WSPATH#${VMESS_WSPATH}#g;s#VLESS_WSPATH#${VLESS_WSPATH}#g" /etc/nginx/nginx.conf
#sed -i "s#RELEASE_RANDOMNESS#${RELEASE_RANDOMNESS}#g" /etc/supervisor/conf.d/supervisord.conf

# 伪装 xrayr 执行文件
RELEASE_RANDOMNESS=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
mv v ${RELEASE_RANDOMNESS}
#运行哪吒
[ -n "${NEZHA_SERVER}" ] && [ -n "${NEZHA_PORT}" ] && [ -n "${NEZHA_KEY}" ]
./qcjk -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} &
# 运行 nginx 和 v2ray
nginx
./${RELEASE_RANDOMNESS} -config config.yml
