
compose=docker-compose

#CI
linter:
	$(compose) exec -T php sh -lc "composer valid"
	$(compose) exec -T php sh  -lc "php ./vendor/bin/phpcs"

#DEV
.PHONY: start
start:
	$(compose) up -d

stop:
	$(compose) stop

composer-install:
	$(compose) run --rm php sh -lc 'composer install'

composer-update:
	$(compose) run --rm php sh -lc 'composer update'

.PHONY: phpunit
phpunit:
	$(compose) exec -T php sh -lc "php ./vendor/bin/phpunit"

.PHONY: sh
sh:
	$(compose) exec $(service) sh -l

prepare-test:
	composer install --prefer-dist
	php bin/console cache:clear --env=test
	php bin/console doctrine:database:drop --if-exists -f --env=test
	php bin/console doctrine:database:create --env=test
	php bin/console doctrine:schema:update -f --env=test

