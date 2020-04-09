brakeman:
	bundle exec brakeman --run-all-checks

reek:
	bundle exec reek

rubocop:
	bundle exec rubocop -a

server:
	bundle exec rails s -p 5000

tests:
	bundle exec rspec
