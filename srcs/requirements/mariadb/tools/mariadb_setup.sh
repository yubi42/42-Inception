#!/bin/sh
MARIADB_ROOT_PASSWORD=$(cat /run/secrets/db_root_pw)
MARIADB_USER_PASSWORD=$(cat /run/secrets/db_user_pw)

if [ -d "/var/lib/mysql/$MARIADB_NAME" ]; then
    echo "Database '$MARIADB_NAME' already exists. Skipping setup."
else
    echo "Starting MariaDB in safe-mode for initial setup...(Networking disabled)"
    mariadbd-safe --skip-networking &

    until mysqladmin ping --silent; do
        echo "Waiting for MariaDB to start before setup..."
        sleep 2
    done

    echo "Performing initial MariaDB setup..."
    mariadb --user=root << EOF
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_ROOT_PASSWORD}');
CREATE DATABASE IF NOT EXISTS \`${MARIADB_NAME}\`;
CREATE USER IF NOT EXISTS \`$MARIADB_USER\`@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON \`${MARIADB_NAME}\`.* TO \`$MARIADB_USER\`@'%';
FLUSH PRIVILEGES;
EOF
    echo "MariaDB setup complete."

    echo "Shutting down MariaDB after setup"
    mysqladmin -u root -p"$MARIADB_ROOT_PASSWORD" shutdown
    sleep 2
fi

echo "Starting MariaDB server...(Networking enabled)"
exec mariadbd --user=mysql --console --skip-networking=0
