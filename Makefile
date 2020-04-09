bundler-audit:
	bundle exec bundle-audit check --update

brakeman:
	bundle exec brakeman --run-all-checks

reek:
	bundle exec reek

rubocop:
	bundle exec rubocop -a

server:
	bundle exec rails s

tests:
	bundle exec rspec
