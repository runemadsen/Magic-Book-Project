require 'rubygems'
require 'bundler'
Bundler.require
require './parser/asciidoc.rb'
require 'yaml'

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/parse' do
    @document = AsciiDoc.new(open("public/test.asciidoc").read)
    erb :parse
  end
  
  get '/design' do 
    @folder = "/images/template1/html/imgs"
    erb :design
  end

  not_found do
    erb :notfound
  end
  
end



