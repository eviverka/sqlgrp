dropdb pizza_db && createdb pizza_db && psql -d pizza_db -f ../materials/model.sql > /dev/null && echo "\033[1;32m===БАЗА СБРОШЕНА===\033[0m"
