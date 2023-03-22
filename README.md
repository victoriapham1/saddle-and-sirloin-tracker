# README  
saddle-and-sirloin-tracker

## Introduction

This ia an application that assists in managing user attendance of organization events as well as all users within the organization. It offers features to view events through Google Calendar API and user authentication with Google Oauth.

## Requirements

This code has been run and tested on:

- Ruby - 3.1.2
- Rails - 7.0.3
- Ruby Gems - Listed in `Gemfile`
- PostgreSQL - 13
- Docker (Latest Container)


## External Deps

- Docker - Download latest version at https://www.docker.com/products/docker-desktop
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
- Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
- GitHub Desktop (Not needed, but HELPFUL) at https://desktop.github.com/

## Installation

Download this code repository by using git:

`git clone https://github.com/victoriapham1/saddle-and-sirloin-tracker`

## Tests

An RSpec test suite is available and can be ran using:

`rspec spec/`

You can run all the test cases by running. This will run both the unit and integration tests.
`rspec .`

## Execute Code

Run the following code in Powershell if using windows or the terminal using Linux/Mac

`cd saddle-and-sirloin-tracker`

`docker run --rm -it --volume "${PWD}:/csce431" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 paulinewade/csce431:latest`


Install the app

`bundle install && rails webpacker:install && rails db:create && db:migrate`


Run the app
`rails server --binding:0.0.0.0`


The application can be seen using a browser and navigating to http://localhost:3000/
