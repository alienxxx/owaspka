

OWASP Karlsruhe Regular Table 14
======================

This Repo contains the example app for the OWASP Karlsruhe Regular Table 14.

Installation
------------

Before we begin (will not be shown): 

    rvm gemset create owasp
    rvm gemset use owasp
    gem install rails

Initiate new Rails app

    rails new owaspka    
    git init #show .gitignore
    vim Gemfile #add 'twitter-bootstrap-rails' and uncomment therubyracer
    rails server

Look at what is already there. Open the rails placeholder page and then follow the steps shown there.

    rails generate scaffold Table topic:string date:datetime agenda:text volume:integer
    rails generate scaffold Participant name:string table:references
    rake db:migrate

Run the server and have a look at how MVC works there. Beautyfy:
        
    rails generate bootstrap:install static
    rails g bootstrap:themed Tables
    rails g bootstrap:themed Participants
    rm app/assets/stylesheets/scaffold.css.scss

Have a look and add a navbar and flash_helpers so we can use the app

    <%= nav_bar :responsive => true, :brand => "OWASP Karlsruhe" do %>
        <%= menu_group do %>
            <%= menu_item "Round Tables", tables_path %>
            <%= menu_item "Participants", participants_path %>
        <% end %>
    <% end %>

    ...

    <div class="container fluid">
        <%= bootstrap_flash %>
        <%= yield %>
    </div>

Edit table model and explain the activerecords associations. Show example image from Henrik and do rails console examples.

    vim app/models/table.rb #add has_many :participants

Configure Routes

    vim config/routes.rb #root 'participants#index'


ActiveRecord (R)
----------------

 1. find_by helpers, explain method missing overwrite
 2. Explain ORM, example line in participants form

        <%= collection_select(:participant, :table_id, Table.all, :id,  :topic, {}, :class => 'form-control') %>

 3. Why it helps to protect from sqli and what needs to be done to create a sqli
         
        user = User.find(:first, :conditions => "user_id = '#{params[:user][:user_id]}'")
        Client.where("first_name LIKE '%#{params[:first_name]}%'")

    Better: 

        Client.where("orders_count = ? AND locked = ?", params[:orders], false)


XSS (H)
-------

 1. html_safe

Devise (R)
-----------

    vim Gemfile # gem 'devise'
    bundle
    rails g devise:install
    rails g devise Admin
    rake db:migrate
    rails g devise:views
    rake routes

Add before_filter in app/controllers/tables_controller.rb

     before_action :authenticate_admin!

Show use of helper methods in application layout. Hiding the menu is not enough!

    <%= menu_item "Round Tables", tables_path if admin_signed_in? %>
    <%= menu_item "Log In", new_admin_session_path unless admin_signed_in? %>        

SessionFixation: Look at cookie during log in. To use it manually, reset_session.


Cookie Store (H)
------------

 1. in rails4 by default encrypted in rails 3 only signed
 2. secret_key_base. 
 3. Is much faster than db lookups.
 4. beware of replay attacks. Know what to store in the cookie  
 5. Expiration, Flags etc. are already set correctly

CSRF (H)
--------

 1. protect_from_forgery    
 2.   <%= csrf_meta_tags %>
 3. cross site script tags disallowed?

Misc (R)
--------

 1. Mass-Assignments 
 2. Password fields ActiveRecord 
 3. has_secure_password 
 4. No passwords in Logging

Further Reading
---------------
 1. http://guides.rubyonrails.org/security.html#cross-site-scripting-xss
 2. RailsGoat

