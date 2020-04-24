include .env.development
export $(shell sed 's/=.*//' .env.development)

audit:
	bundle exec bundle-audit check --update

brakeman:
	bundle exec brakeman --run-all-checks

docker-build:
	docker-compose build

docker-up:
	docker-compose up

reek:
	bundle exec reek

rubocop:
	bundle exec rubocop -a

run:
	docker-compose run api $(CMD)

server:
	bundle exec rails s

standard:
	bundle exec standardrb --fix

stats:
	bundle exec rails stats
