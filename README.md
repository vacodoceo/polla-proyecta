# Polla Proyecta

## Setup:
Setup consist on building the docker-container

``` docker-compose build ```

Creating the database

``` docker-compose run web rails db:create ```

And running migrations

``` docker-compose run web rails db:migrate ```

## Run:

``` docker-compose up ```
