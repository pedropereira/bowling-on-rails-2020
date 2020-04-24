include .env.development
export $(shell sed 's/=.*//' .env.development)

audit:
	bundle exec bundle-audit check --update

brakeman:
	bundle exec brakeman --run-all-checks

build:
	docker-compose build

down:
	docker-compose down

reek:
	bundle exec reek

rubocop:
	bundle exec rubocop -a

run:
	docker-compose run --service-ports api zsh

server:
	bundle exec rails s -p $(PORT) -b 0.0.0.0

specs:
	bundle exec rspec

standard:
	bundle exec standardrb --fix

stats:
	bundle exec rails stats
