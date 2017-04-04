# Búálfur Server  - Property Search Engine

## Project members

* [Egill Ian Guðmundsson](https://github.com/egillian1)
* [Hildur Sigurjónsdóttir](https://github.com/hildurs)
* [Oddgeir Páll Georgsson](https://github.com/oddgeirpall)
* [Stefán Carl Peiser](https://github.com/stefancarlpeiser)


## Installation

### Prerequisites

You need to have the following installed before continuing:

* Ruby
* Rails
* PostgreSQL

### Set up

Download the project and install all the necessary packages with the
`bundle install` command.

Once done create the necessary database with `rake db:create`

Now you need to add the "uuid-ossp" extension to the newly created database,
this is done by executing the following commands after logging in as the appropriate
user:

    $ psql
    user=# \connect hugbo_leiga_development
    user=# CREATE EXTENSION "uuid-ossp";

You can also do this through the pgAdmin GUI.

Once you have created the extension go back to the project folder and make the necessary migrations to the db and import the seed

    rake db:migrate db:seed

Next create the environment file by executing `bundle exec figaro install`

Now you need to insert the proper info to your `applications.yml` file, with values you get from Facebook, the file should look like

    FACEBOOK_KEY: "Your facebook app id goes here"
    FACEBOOK_SECRET: "Your facebook app secret goes here"
    HASH_SEED: "Your seed goes here"

You can generate a seed which you can use with HASH_SEED by executing `rake secret`, though it can be something else entirely

Everything should be ready now, to run the server simply execute the command `rails s`
