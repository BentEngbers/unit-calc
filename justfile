


test:
    flutter test

test-coverage: 
    flutter test --coverage

coverage-html:
    grcov ./coverage/lcov.info -t html

refresh-coverage: test-coverage coverage-html

auto-refresh-coverage: 
    watchexec --restart  --exts dart just refresh-coverage