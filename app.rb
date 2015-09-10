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
	c = Client.new params[:client]
	c.save	

	erb "<h2>Thanks!</h2>"
end