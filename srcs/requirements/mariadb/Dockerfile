FROM alpine:3.18

RUN apk update && \
    apk add mariadb mariadb-common mariadb-client

COPY /conf/custom.cnf /etc/my.cnf.d/

COPY /tools/mariadb_setup.sh /usr/local/bin/mariadb_setup.sh
RUN chmod +x /usr/local/bin/mariadb_setup.sh

# >/dev/null redirecting in tmp file, so that we dont see installing output
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db #> /dev/null

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

EXPOSE 3306

USER mysql

ENTRYPOINT [ "/usr/local/bin/mariadb_setup.sh" ]
