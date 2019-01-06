# -=-=-=- RAILS NOTES -=-=-=-

# Rails server template start-up

#  $  rails new (project name)

bin/rails about
=begin

this command lists info about the built project if in the directory already

put the bin before the rails command runs the rails command in the bin directory
this command is a wrapper or binstub for the rails exetuable

=end

# -=- server start command -=-
bin/rails server
# or
rails server

# specifying other network ports

bin/rails server -b 0.0.0.0

# Making the MVC framework

bin/rails generate controller Say hello goodbye

=begin
rails generate will create the controller for us
the 'Say' controller will have both actions hello and goodbye 

the command generated say_controller.rb in demo/apps/controllers:
inherits the baseline application_controller.rb;
class SayController < ApplicationController
  def hello
  end

  def goodbye
  end
end


=end

# Creating dynamic content in Rails

=begin
.html.erb suffix allows us to embed ruby code in the template
creating a dynamic page that can be altered by interaction or the controller

ERB is a filter, that takes and .erb file and putputs a transformed version. 
the output is often HTML in Rails but it can be anything
Normal content is passed through without being changed
however content between <%= %> is interpreted as Ruby code and executed
The result of that exevution is convered into a string and that value is substituted on the page

The rails dispatcher automatically fetches new changes on each request when in development mode
This feature should be disabled for production
=end


# Rails helper methods for views
=begin
link_to() which creates a hyperlink to an action(this method can do a lot more than this too)
<%= link_to "Goodbye", say_goodbye_path %>

say_goodbye_path is a precomputed value that Rails makes available to application views
it evaluates as /say/goodbye path
Rails provides the ability to name all the routes that you use in your application

=end

# Rail debugging
=begin
the web console is configured to only be shown when accessed from the same machine as the web server
you can enable the console to be seen by all and some other features	
=end


# Rails MVC cont'd
=begin

In a rails application, an incoming request is first sent to a router
which works out where in the application the request should be sent and how the request should be parsed
Ultimately this phase identifies a particular method(called an action in rails parlance) somewhere in the controller code
the action might look at data in the request, it might interact with the model, and it might cause other actions to be invoked
eventually the action prepares information for the view, which renders something to the user


Rails MVC handles incoming requests much like Django, with upfront router methods

=end

# Rail ORM
=begin

Object-relational mapping (ORM) libraries map database tables to classes.

In addition, the Rails classes that wrap our database tables provide a set of class-level methods that perform table-level operations


examples of rails orm methods:
=end
order = Order.find(1)
puts " customer #{order.customer_id}, amount = $#{order.amount}"	
=begin
sometimes these class-level methods return collections of objects:
=end
Order.where(name: 'david').each do |order|
	puts order.amount
end
=begin
Finally the objects corresponding to individual rows in a table have methods
that operate on that row. Probably the most widely used is save(),
the operation that saves the row to the database:
=end

Order.where(name: 'dave').each do |order|
	order.pay_type = "Purchase order"
	order.save
end
=begin

an ORM layer maps tables to classes, rows to objects, and columns to attributes of those objects
Class methods are used to perform table-level operations, and instance methods perform operation on the individual rows

I a typical ORM library, you supply configuration data to specify the mappings between entities in the database and entities in the program
Programmers using these ORM tools often find themselves creating and maintaining a boatload of XML config files
=end

=begin
Active Record

Active record is the ORM layer supplied with Rails. It closely follows the standard ORM model:
tables map to classes, rows to objects, and columns to object attributes

It differs from most other ORM libraries in the way it;s configured. 
By relying on convention and starting with sensible defaults, Active Record minimizes the amount of config that developers perform


=end
require 'active_record'

class Order < ActiveRecord::Base
end

order = Order.find(1)
order.pay_type = "purchase order"
order.save
=begin
Active Record can extract application data into our models
Active Record supports sophisticated validation of model data, and if the form data fails validations, it formats errors

=end

=begin
Action Pack - The View and Controller
The Views
ERB - views templating scheme Embedded Ruby

ERB can construct JS fragments on the server that are then executed on the browser
this is great for creating dynamic Ajax interfaces

Rails also provides XML Builder to construct XML documents 

The Controllers
	routes external requests to internal actions

	it manages caching which can give your applications performance boosts

	it manages helper modules, which extend the capabilities of the view templates without bulking up their code

	it manages sessions, giving users the impression of ongoing interaction with out applications


=end
# ruby shortcut for creating an array of words
#  a = %w{ sample one two three}

=begin
inst_section = {
	:one => 'string',
	:two => 'other string'
}
need to use the arrow syntax when the key is not a symbol

other method:
inst_section = {
	one: 'string',
	two: 'other string'

}

=end

# Regular Expressions
=begin
if line =~ /P(erl|ython)
	puts "string"
end

/ab+c/
matches a string containing an a followed by one or more 'b's followed by a c

/ab*c/ 
matches one a, zero or more b, and one c

backward slashes start special sequences:
\d matches any digit
\w matches any alphanumeric character
\A matches the start of the string
\Z matches the end of the string
\ with a wildcard character (.,;:....) matches the wildcard character
*see the PickAxe book for a full discussion

=end

#  animals = %w(ant bee cat dog elk)
#  animals.each {|aninmal| puts animals}

# 3.times {puts 'Hello'}

=begin
the & prefix operator allows a method to capture a passed block as a named parameter
def wrap &b
	print "Santa Says : "
	3.times(&b)
	print "\n"
end
wrap { print "Ho!"}

=end

=begin
Ruby Exceptions

the raise method causes an exception to be raised, this interrupts the normal flow through the code
instead ruby seaches back through the call stack for code that can handle it

begin
	content = load_blog_data(file_name)
rescue BlogDataNotFound
	STDERR.puts "File #{file_name} not found"
rescue BlogDataFormatError
	STDERR.puts "File #{file_name} invalid format"
rescue Exception => exc
	STDERR.puts "General error loading file"
=end

=begin
Class Structures

class Order < ApplicationRecord
	#Active Record definition for one to many relationships
	has_many :line_items
	#instance variable
	@demo_var
	#self. makes this a class method that any instance can call on
	def self.find_all_unpaid
		self.where('paid = 0')
	end
	def total
		sum = 0
		line_items.each {|li| sum += li.total}		
		sum
	end
end


Class methods are public by default. anyone can call them

class MyClass
	def m1 #this method is publid
	end

	protected
	def m2 #this method is protected
	end

	private
	def m3 #this method is private
	end

private directive is the strictest, can only be called from within the same instance

protected methods can be called both in the same instance and by other instances of the same class
=end


=begin
YAML - YAML Aint Markup Language
used as a convienent way to define the config of things like dbs, test data, and translations

example:
development:
	adapter: sqlite3
	database: db/development.sqlite3
	pool: 5
	timeout: 5000

this defines development as having 4 key-value pairs

=end

=begin
Combined example
=end
class CreateProducts < ActiveRecord::Migration[5.0]
	def change
		create_table : prodcuts do |t|
			t.string :title
			t.text :description
			t.string :image_url
			t.decimal :price,precision: 8, scale: 2

			t.timestamps
		end
	end
end

=begin
Ruby Idioms

count ||=0
gives count the value of 0 if count is nil or false

lambda ->

references:
https://www.ruby-lang.org/en/documentation/ruby-from-other-languages/

http://www.zenspider.com/ruby/quickref.html
=end

=begin
Magic command worth knowing:
bin/rails db:migrate:redo

it'll undo and reapply the last migration
=end

=begin
Rails project startup cheat sheet:

#new project folder and subfolders
rails new (project name)

#generates a scaffold for a Product model, the '\' allows for multiline input
bin/rails generate scaffold Product \ title:string description:text image_url:strings price:decimal


#if you change something in the models or db, use this to update
bin/rails db:migrate



#testing the server
bin/rails test
#this is for the model and controller tests that Rails generates along with thte scaffolding
#Run this frequently to spot problems early and often


#seed the db, using the seed.rb file
bin/rails db:seed
=end

=begin
	Validation:
=end
	class Product < ApplicationRecord
		validates :title, :description, :image_url, presence: true
		validates :price, numericality: {greater_than_or_equal_to: 0.01}
	end
=begin
Fixtures
A fixture is an environment in which you can run a test

a test fixcture is a specification of the initial contents of a model or models under test

loads the data corresponding to the given model name into the corresponding database table
fixtures :products

=end




