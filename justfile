


test:
    dart test

test-coverage: 
    dart test --file-reporter="json:test-results.json" --coverage=./coverage/
    dart run coverage:format_coverage --base-directory=. --report-on=./lib --lcov --in coverage --out coverage/lcov.info

coverage-html: test-coverage
    grcov ./coverage/lcov.info -t html


auto-refresh-coverage: 
    watchexec --restart  --exts dart just refresh-coverage