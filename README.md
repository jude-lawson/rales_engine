# Rales Engine

#### Collaborators: Judson Stevens and Jude Dutton

## Summary of Project

  In this project, we were challenged to take large files of data and set up an API only Rails app that would respond to different user queries and requests. The responses should include relevant information about the request, including records and other business "intelligence" operations. The rubric and guide to the project is linked below. 
  
  The Rales Engine project was an exploration of how to serve up data as an API, which is of course an integral part of almost every web application.

## Setup & Installation

  To get put this project on your own machine, follow these steps:
  1. Clone down the project from this repository, or fork it from this repository to your own.
    `git clone git@github.com:jude-lawson/rales_engine.git`
  2. Once the project has been cloned into your folder, navigate to that folder and run
    `bundle install`
    `bundle update`
  3. Once the gems have finished updating, you can create the Postgres database and tables by running 
    `rake db:{create,migrate}`
  4. After creating the database, we need to seed the database with the information contained in the CSV files located in db/csv. To do this, we have built a rake task. Run this rake task by running
    `rake seed_all_data`
  5. Once the database has been seeded, you can run our RSpec test suite by running
    `rspec`
  6. To start and interact with the server on your local machine, run
    `rails s`
  7. After running the previous command, open a browser window and type `localhost:3000` into the address bar.
  8. Once you see the Rails welcome page, you can start to interact with the data using the endpoints located in the rubric and guide linked below.
  
## Rubric and Guide

  http://backend.turing.io/module3/projects/rails_engine
