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
	@barber		= params[:barber]
	@color		= params[:color_picker]


	c = Client.new
	c.name = @username
	c.phone = @phone
	c.datestamp =@date_time
	c.barber = @barber
	c.color =@color
	c.save

end