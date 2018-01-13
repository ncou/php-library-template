.PHONY: bench composer coverage cs infection it stan test

it: cs stan test bench

bench: composer
	vendor/bin/phpbench run --report=aggregate

composer:
	composer self-update
	composer validate
	composer install

coverage: composer
	vendor/bin/phpunit --configuration=test/Unit/phpunit.xml --coverage-text

cs: composer
	vendor/bin/php-cs-fixer fix --config=.php_cs --diff --verbose

infection:
	vendor/bin/infection --min-covered-msi=80 --min-msi=80

stan:
	vendor/bin/phpstan analyse -l 7 src

test: composer
	vendor/bin/phpunit --configuration=test/Unit/phpunit.xml
	vendor/bin/phpunit --configuration=test/Integration/phpunit.xml
