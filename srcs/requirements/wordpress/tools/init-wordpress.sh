#!/bin/bash
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_pw)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_pw)
MARIADB_USER_PASSWORD=$(cat /run/secrets/db_user_pw)

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
while ! mysqladmin ping -h"$MARIADB_HOST" --silent; do
    sleep 1
done

# Install WordPress if not installed
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Setting up WordPress..."

    wp config create --allow-root \
                --dbname=$MARIADB_NAME \
                --dbuser=$MARIADB_USER \
                --dbpass=$MARIADB_USER_PASSWORD \
                --dbhost=$MARIADB_HOST:3306 \
                --path=$WP_PATH

    # Install WordPress
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email="admin@placeholder.com" \
        --skip-email \
        --path=$WP_PATH

    # Create additional user
    wp user create $WP_USER "user@placeholder.com" \
        --role=author \
        --user_pass=$WP_USER_PASSWORD \
        --path=$WP_PATH \
        --allow-root

    echo "WordPress setup completed."
else
    echo "WordPress already installed."
fi

echo "Starting PHP-FPM..."
exec php-fpm7.4 -F