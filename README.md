<div align=center>
  <h1>Flick Finder</h1>
  Flick Finder is a Movie search API that allows for one to enter in their movie query and sort by release date. The application functions by saving searches and     movies in it's database for maximum efficiency and speed. <a href="https://murmuring-atoll-28027.herokuapp.com/">Here's a link</a> to the application; read the   documentation below and try it yourself! Recommendations & bug fixes are welcome by pull request from a forked repository.
</div>

***

## Table of Contents
[Prerequisites](#prerequisites)  
[Installation](#installation)  
[Schema Design](#schema-design)  
[Running the App](#running-the-app)  
[Endpoints](#endpoints)  
[Built With](#built-with)  
***
## Prerequisites
*To run this app, you will need:*
- Ruby 2.5.3
- Rails 5.2.6
- Bundler 2.2.17
- Rbenv 1.1.2
***
## Installation
1. Fork and clone this repository to your local drive
2. Run the following commands in order:
- `bundle install`
- `rails db:create`
- `rails db:migrate`
3. For this app to work in development, you will need to gain an access key from [The MovieDB](https://www.themoviedb.org). To gain an api key:
- Create an account
- Go to the API section in your Account Settings
- request an API key (This could take upwards of a week to gain, so think ahead)

Once you've gained your API access, you will need to install `figaro` locally:
- From the app's root directory, run `bundle exec figaro install`. This should create a file named `application.yml` within your `config` directory.
- In that file, write `MOVIEDB_TOKEN: {your bearer token}`. *Note: this is the BEARER TOKEN authorization method, not with the API key. You will see both in the api section of your MovieDB account settings.*

You should be all set up! to make sure: 
- Run `bundle exec rspec` to confirm all tests are passing.
- Start your local server using the `rails s` command and mess around a little bit.
***
## Schema Design
![Schema Design](https://user-images.githubusercontent.com/72848529/121088570-2cca8a80-c7a3-11eb-8fa4-9670504b3821.png)
***
## Running the App
- Follow installation instructions and run a local server by executing `rails s` in the root directory
- Heroku: https://murmuring-atoll-28027.herokuapp.com/
    - *note: one must enter in the endpoint below for the app to start. there is no welcome page*
***

## Endpoints
### Search Movies
`GET '/api/v1/movies'`
  
**Required** Path Params:
- `query`: search term

**Optional** Path Params:  
`sort`: sort results in descending order. Allowed arguments:
- `date`

**You will recieve a 404 response if:**
- query is missing or blank

`GET '/api/v1/movies?query=notebook'`

*response status: 200*

>```JSON
>{
> "data": [
>   {
>     "id": "11036",
>     "type": "movie",
>     "attributes": {
>       "title": "The Notebook",
>       "release_date": "2004-06-25",
>       "description": "An epic love story centered around an older man who reads aloud to a woman with Alzheimer's. From a faded notebook, the old man's words   >                       bring to life the story about a couple who is separated by World War II, and is then passionately reunited, seven years later, after they                         have taken different paths.",
>       "popularity": "38.04",
>       "vote_average": "7.9"
>      },
>      "relationships": {
>       "searches": {
>         "data": [
>           {
>             "id": "2",
>             "type": "search"
>           }
>         ]
>        }
>      }
>    },
>    {"..."},
>  ]
>}

***
## Built With
- `Ruby on Rails`
- `Rspec`
- `Figaro`
- `Webmock`
- `VCR`
- `Fastjson_API`
- `Faraday`
- `Capybara`

***

## Author
*Trevor Suter*  
*[LinkedIn](https://www.linkedin.com/in/trevor-suter-216207203/)*
