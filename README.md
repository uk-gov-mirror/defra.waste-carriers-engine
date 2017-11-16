# Waste Carriers renewals

The Waste Carrier Registrations Service allows businesses, who deal with waste and thus have to register according to the regulations, to register online. Once registered, businesses can sign in again to edit their registrations if needed.

The service also allows authorised agency users and NCCC contact centre staff to create and manage registrations on other users behalf, e.g. to support 'Assisted Digital' registrations. The service provides an internal user account management facility which allows authorised administrators to create and manage other agency user accounts.

The renewals application allows users who registered using the Waste Carrier Registrations Service to renew their registrations.

## Prerequisites

Make sure you already have:

- Git
- Ruby 2.4.2
- Rails 4.2.10
- [Bundler](http://bundler.io/) – for installing Ruby gems
- MongoDb

## Installation

A Vagrantfile has been created allowing easy setup of the waste carriers applications, databases and dependencies. This is located within Gitlab.

Download the Vagrantfile and run the VM using `vagrant up`. Once the VM is set up and has installed all the other elements of the Waste Carriers service, you can install the renewals application.

You can do this on your local machine, but make sure the VM is also up and running.

Clone the repo:

`git clone git@gitlab-dev.aws-int.defra.cloud:waste-carriers/waste-carriers-renewals.git`

Change to the directory:

`cd waste-carriers-renewals`

And install the dependencies:

`bundle install`

### Databases

Registration data and user data for the Waste Carriers service are held in 2 MongoDb databases. Multiple applications for the service use these databases, including this one.

If you are using the Vagrant image, running `vagrant up` should set up the development databases for registrations and users.

The renewals application also has 2 separate test databases. Currently you will need to create these yourself. Create these on the VM.

`mongo waste-carriers-test --eval 'db.addUser({user: "mongoUser", pwd: "password1234", roles:["readWrite", "dbAdmin", "userAdmin"]})'`

`mongo waste-carriers-users-test --eval 'db.addUser({user: "mongoUser", pwd: "password1234", roles:["readWrite", "dbAdmin", "userAdmin"]})'`

If you get a permissions error when trying to create the databases, you may need to remove the auth requirements in `/etc/mongodb.conf`. Restart Mongo after doing this for changes to take effect.

## Seed data

The renewals application relies on users being created as part of waste-carriers-frontend. However, you can seed the database with a test user so you can log in and access the features. (This won't work in production.)

Seed the databases with:

`bundle exec rake db:seed`

## Running the application

Start the application with:

`bundle exec rails s`

## Testing the app

The test suite is written in RSpec.

To run all the tests, use:

`bundle exec rspec`
