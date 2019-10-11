#!/usr/bin/env bash

set -e

SERVICE_ROLE=${SERVICE_NAME:-app}
SERVICE_ENV=${APP_ENV:-production}

function console.group() {
    echo -e ">>>>>>>>>> $1 >>>>>>>>>>"
}

function console.error() {
    echo -e "!!!!!!!!!! $1 !!!!!!!!!!"
}

# Chaning directory to /var/www
cd /var/www

if [ "$SERVICE_ENV" != "local" ]; then
    echo "Caching configuration..."

    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
# else
    # php artisan clear-compiled
    # php artisan config:clear
    # php artisan route:clear
    # php artisan view:clear

    # composer dump-autoload
fi

case "$SERVICE_ROLE" in
    "app")
        # Running tasks for "app" container
        console.group "Preparing Application..."
        php artisan storage:link -q || true

        console.group "Starting Application Service..."
        # php artisan inspire
        exec php-fpm
    ;;
    "queue")
        console.group "Starting Queue Service..."
        if [ -f "config/horizon.php" ]; then
            php artisan horizon --verbose
        else
            php artisan queue:work --verbose
        fi
    ;;
    "scheduler")
        console.group "Starting Scheduler Service..."
        while [ true ]
        do
            php artisan schedule:run \
                --verbose \
                --no-interaction &

            sleep 60
        done
    ;;
    "websocket")
        console.group "Starting WebSocket server..."
        php artisan websockets:serve \
            --host=${WEBSOCKET_HOST:-0.0.0.0} \
            --port=${WEBSOCKET_PORT:-6001} \
            --verbose
    ;;
    *)
        console.error "Could not match the container role \"$SERVICE_ROLE\""
        exit 1
    ;;
esac
