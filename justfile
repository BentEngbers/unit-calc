

# run the tests of this project
test:
    dart test

# run the tests of this project, with coverage.
test-coverage: 
    dart test --coverage=./coverage/
    dart run coverage:format_coverage --base-directory=. --report-on=./lib --lcov --in coverage --out coverage/lcov.info

# run the tests with coverage, and generate a html page from the coverage. The output can be found in the ./html directory. 
coverage-html: test-coverage
    grcov ./coverage/lcov.info -t html

# run the tests with coverage, and generate a html page from the coverage.
coverage-html-watch: 
    watchexec --restart  --exts dart "just coverage-html"