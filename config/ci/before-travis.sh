#fix schema
wget https://raw.github.com/diaspora/diaspora/master/db/schema.rb
cp schema.rb db/schema.rb

# Regenerate css files
echo "Regenerating CSS files"
bundle exec sass -q --update public/stylesheets/sass/:public/stylesheets/

# Create a database.yml for the right database
echo "Setting up database.yml for $DB"
cp config/database.yml.example config/database.yml
if [ "$DB" = "postgres" ]; then
  sed -i 's/*mysql/*postgres/' config/database.yml
fi

# Set up database
echo "Creating databases for $DB and loading schema"
bundle exec rake db:create
bundle exec rake db:schema:load
echo "Kittens"
