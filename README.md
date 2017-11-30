## Welcome to Shopper!

Shopper is a simple online shop implemented in Ruby on Rails framework. It has been written from scratch by a shop owner Mr Tom Peanutbutter who does not have a professional background in web development but he has heard that Ruby on Rails is really easy even for newbies so he decided to create an online shop by himself. At first everything went smooth but currently Mr Peanutbutter is struggling to introduce some changes to the code base. So he asked you to refactor Shopper!

### Business domain
There are some things about the Shopper's business logic which you might want to know before you dive into the code:
1. Every customer needs to create an account in Shopper so that he/she can place an order.
2. Only one product can be placed in a single order, however customer can order X amount of this product (so the customer can order 3 Samsung S8 smartphones but not a Samsung S8 and Apple Iphone 7 within one order).
3. Customer is able to specify whether he/she wants to purchase products with immediate payment (using his credit card details) or with a regular cash transfer. In case customer allows for immediate payment the order is ready to be delivered to the customer immediately (otherwise Mr Peanutbutter needs to wait for the cash transfer).
4. Occasionally Mr Peanutbutter kicks off special offers that apply to all products in his stock. The special offers are specified with a given discount value and time period when they are applicable. Notice: discounts sum up so in case a Black Friday with 10% and Total Sales Week with 5% off are taking place at the sam time the customer is given 15% for his whole order.

### What now?
Mr Peanutbutter has given you access to the admin panel for you to play around with the app (credentials are given in `db/seeds.rb`) and a free hand in terms of refactor. The only thing he asked you for is to make Shopper great again!

For the simplicity of this task we would ask you to focus on `OrdersContoller#create` action. However, do not limit yourself to refactoring only this place in the appplication since you may find some code smells in other places in the application ;).

### Notice
Currently there is only one spec within the project implemented for `OrdersController#create` action - it's kind of an integration test for this action what means we do not want to fail this test along the refactor process. Please do not modify this spec and feel free to add other specs!

### Setup

To setup app type `bin/setup`

### Running app

To run application type `foreman start`

Application will be run on `localhost:5000` by default

You can change port with `-p` flag, example: `foreman start -p 3000`


### Run tests

To run whole test suite type `bundle exec rspec`