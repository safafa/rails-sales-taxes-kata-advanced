ReceiptManager
======================
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)

Functionality that allows you to upload receipts and save them under a User profile. From each receipt you can see the total price you spent as well as the total sales tax. It automatically calculates the taxes based on the products that are on the receipt. It is configurable, allowing you to change the data which is involved around taxes. Such as what categories are exempt from sales tax, what products in the store to base the receipt products on.

Test out the functionality on a [live demo app](https://the-receipt-manager.herokuapp.com/)

### Note
If you go to the live server or clone it, ReceiptManager is configured through Devise that users will need to confirm their signup via email.

In development the easiest way to confirm the user is via `rails console` like so:

```
User.find_by(email: 'username@email.com').confirm
```

## Pre-requisites:
- Ruby v2.6.6
- Ruby on Rails v6.1.4
- sqlite3

## Recommended:
- Bundler
- RBenv

## Configuration to your database
### ReceiptManager module
If you wish to include `ReceiptManager` logic in an existing app, you might have the scenerio where
you want to include logic apart from the `User` and `Product` models, as you might have these already. If you do have these models but are named differently, you will need to do some configuration.

Create a `ReceiptManager` module in `/lib` and add the necessary constants. For example:
```ruby
  PRODUCT_CLASS = ShopProduct # your Product class
  USER_CLASS = Customer # your User class
```

`ReceiptManager` also needs to know what category the products belong to in order to calculate sales taxes correctly. If you have a category class that `has_many` "Product"s and if it has an attribute of `name`, then you need no configuration. But for example if `category` is an `enum` in the "Product" model then you will need to override the `ReceiptManager` module method like so:
```ruby
  def category_name(category)
    category # overrides the default `category.name`
  end
```

### TaxHandler module
Lastly, you may want to override some constants in the `TaxHandler` module such as `EXEMPT_SALES_TAX_CATEGORIES` or `IMPORT_TAX_DECIMAL` depending on your country's tax regulations. Create a `TaxHandler` module in `/lib` and overwrite the constant simarly to:
```ruby
 EXEMPT_SALES_TAX_CATEGORIES = %w[book food medical].freeze
```


Clone the project
------------
```
$ git clone git@github.com:RyanofWoods/rails-sales-taxes-kata-advanced.git rails-receipt-manager
$ cd rails-receipt-manager
```

> If you use bundler as your package manager:
```
$ bundle install
```

> Setup database with:

```
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

Run the tests
------------
This runs only normal tests and no minitest system (feature) tests 
```
$ rails test
```

This runs only minitest system (feature) tests
```
$ rails test:system
```

This runs normal system tests. Note the order is important
```
rails test:system test
```

Run rubocop
------------
```
$ rubocop
```

Start the server
------------
Start server with:

```
$ rails server
```

Open `http://localhost:3000/` in your browser.

Caveats
------------
- Sales tax and import tax percentages as well as the categories exempt from sales tax are constants, however, these are not constant in real-life and will change over time. However, ReceiptManager currently has no way of recording these changes. Thus old receipts may be calculated incorrectly.
- If you have products where their names may be changed and that you have no record of these changes,
  then the ReceiptManager will not find the corresponding product through the receipt product name. If you do keep track of these changes, you will need to override some ReceiptManager logic so you can find the receipt Products which names have changed.

Contributing
------------
All contributions are welcome. To increase the chances of merging your `Pull requests`, do the following:
- Follow Rails' conventions and idiomatics
- Add tests for new functionality
- Ensure that the test suite is green and that there are no new `rubocop` style offenses with every commit
- Ensure that a commit only has only one logical change
- Add [good commit messages](https://github.com/erlang/otp/wiki/Writing-good-commit-messages) explaining why the changes were made and any important details
- Achieve clean fast-forwarding commits by `rebasing` over `merging` -> [information](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)
