#
# Included by script/server
#
THIN_PORT=3000
SOCKET_PORT=8080

#export RAILS_ENV='development'
export RAILS_ENV='production'

# See thin -h for possible values.
DEFAULT_THIN_ARGS="-p $THIN_PORT -e $RAILS_ENV -s 2"

# Set to 'no' to disable server dry-run at first start
# creating generated files in public/ folder.
#INIT_PUBLIC='no'
