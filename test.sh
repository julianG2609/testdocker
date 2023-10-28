#!/bin/bash

# Create a Docker network
docker network create laravel_net

# Start the MySQL container
docker run --name laraveldb --net laravel_net -p 3306:3306 -d \
   -e MYSQL_USER=myuser \
   -e MYSQL_PASSWORD=password \
   -e MYSQL_DATABASE=laravel \
   -e MYSQL_ALLOW_EMPTY_PASSWORD=true  \
   mysql:latest

# Start the Laravel.io application container
docker run --name laravel --net laravel_net -p 80:8000 -d \
   -e DB_CONNECTION=mysql \
   -e DB_HOST=laraveldb \
   -e DB_DATABASE=laravel \
   -e DB_USERNAME=myuser \
   -e DB_PASSWORD=password \
   laravelio

# Wait for Laravel.io to start (you can customize this part)
sleep 10

# Check the availability of the application
response_code=$(curl --write-out '%{http_code}' --silent http://localhost:80/ --output /dev/null)

if [ $response_code -eq 200 ]; then
   echo "Test Passed: Laravel.io is available."
   exit 0
else
   echo "Test Failed: Laravel.io is not available. HTTP Status Code: $response_code"
   exit 1
fi
