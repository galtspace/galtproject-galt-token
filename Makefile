.PHONY: test benchmark report

cleanup:
	rm -rf ./build

compile: cleanup
	./node_modules/truffle/build/cli.bundled.js compile
	tput bel

validate:
	npm run ethlint
	npm run eslint

test:
	-npm test
	tput bel

benchmark:
	for file in `ls ./benchmark`; do echo \\n$${file}\\n; ./node_modules/.bin/truffle exec benchmark/$${file} --network test -c; done

deploy:
	rm -rf build && ./node_modules/.bin/truffle migrate --network local
