web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
log: touch log/development.log && tail -n 0 -f log/development.log
