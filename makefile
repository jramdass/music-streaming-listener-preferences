run:
	bin/rails server &

test: run
	npx cypress run

console:
	bin/rails console