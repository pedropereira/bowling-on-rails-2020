audit:
	bundle exec bundle-audit check --update

brakeman:
	bundle exec brakeman --run-all-checks

reek:
	bundle exec reek

rubocop:
	bundle exec rubocop -a

server:
	bundle exec rails s

specs:
	bundle exec rspec

standard:
	bundle exec standardrb --fix

stats:
	bundle exec rails stats
