#!/usr/bin/env bash

red=$(tput setaf 1)
none=$(tput sgr0)
# directory=""

show_help() {
    printf "usage: $0 [--help] [--report] [--test] [<path to package>]
Script for running all unit and widget tests with code coverage.
(run from root of repo)
where:
    <path to package>
        runs all tests with coverage and reports
    -t, --test
        runs all tests with coverage, but no report
    -r, -c, --report
        generate a coverage report
        (requires lcov, install with Homebrew)
    -h, --help
        print this message
"
}

run_tests() {
    if [[ -f "pubspec.yaml" ]]; then
        rm -f coverage/lcov.info
        rm -f coverage/lcov-final.info
        flutter test --no-pub --coverage
    else
        printf "\n${red}Error: this is not a Flutter project${none}"
        exit 1
    fi
}

run_report() {
    if [[ -f "coverage/lcov.info" ]]; then
        lcov -r coverage/lcov.info \
            '*/__test*__/*' \
            '*.g.dart' \
            '*.freezed.dart' \
            -o coverage/lcov_cleaned.info
        genhtml -o coverage coverage/lcov_cleaned.info
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open coverage/index-sort-l.html
        elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
            start coverage/index-sort-l.html
        fi
    else
        printf "\n${red}Error: no coverage info was generated${none}"
        exit 1
    fi
}

case $1 in
-h | --help)
    show_help
    ;;
-t | --test)
    printf "Start Test"
    if [ ! -z "$2" ]; then
      directory=$2
    fi
    printf "TEST IN $directory"
    run_tests
    ;;
-r | -c | --report)
    run_report
    ;;
*)
    if [ ! -z "$1" ]; then
      directory=$1
    fi
    run_tests
    run_report
    ;;
esac
