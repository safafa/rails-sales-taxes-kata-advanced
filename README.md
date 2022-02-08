# Rails Sales taxes advanced

> Simple rails app that allows the users to create accounts, upload a file with the content of a basket then print their receipts on the web page and keep their receipts history.

![image](https://user-images.githubusercontent.com/43698511/152758272-6c70d26e-d7e6-4f9a-bf3b-11e0d8d2fe31.png)

## Live Demo

[Link](https://taxes-kata-advanced.herokuapp.com/)

## Built With

- Ruby v2.7.1
- Ruby on Rails v6.0.4

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.7.1

npm: run <code> npm install </code>

yarn: run <code> npm install --global yarn </code>

Rails: 6.0.4
 
### Setup

Clone the repository with:
```
git clone https://github.com/safafa/rails-sales-taxes-kata-advanced.git
```
Move to the root directory

API Key:
You can sign up for a free account to get your API Key check https://thecatapi.com/.

Open <code> app/models/cat_api.rb </code> and replace

```
api_key: ENV['API_KEY']
```
with

```
api_key: "Your personal API key"
```

Install gems with:

```
bundle install
```

Setup database with:

```
   rails db:create
   rails db:migrate
```



### Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

```
    rspec 
```
