require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

get '/' do
	@barbers = Barber.order "created_at DESC"
	erb :index	
end

before do 
	@barbers = Barber.all
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@username  	= params[:username]
	@phone  	= params[:phone]
	@date_time 	= params[:date_time]
	@person		= params[:person]
	@color		= params[:color_picker]

	hh = { :username => 'Enter your name',
		   :phone => 'Enter your phone',
		   :date_time => 'Enter date and time'}

	hh.each do |key,value|
		if 	params[key] == ''
			@error = hh[key]
			return erb :visit
		end
	end

	db = get_db
	db.execute 'INSERT INTO
	 			Users 
	 			(
	 				username, 
	 				phone, 
	 				datestamp, 
	 				person, 
	 				color
	 			)
				values(?,?,?,?,?)', [@username,@phone,@date_time,@person,@color]


	f = File.open("./public/users.txt", "a") 
	f.write("User: #{@username} Phone: #{@phone} Date and Time: #{@date_time} Person: #{@person} Color: #{@color}\n");
	f.close;

	erb "<h2>Thanks for visit</h2>"
end