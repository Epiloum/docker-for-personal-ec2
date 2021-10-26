FROM haproxy:2.4.7-alpine

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
#RUN haproxy -f /usr/local/etc/haproxy/haproxy.cfg

#CMD [ "haproxy", "-f /usr/local/etc/haproxy/haproxy.cfg; dockercloud-haproxy" ]
#CMD [ "dockercloud-haproxy" ]
#RUN haproxy -f /usr/local/etc/haproxy/haproxy.cfg
