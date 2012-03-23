require 'rubygems'
require 'bundler'
Bundler.require
require './helpers/magicrocco'

class Application < Sinatra::Base
   
  get '/' do
    erb :front
  end
  
  get '/create_html' do
    @document = AsciiDoc::AsciiDocument.new("templates/book.asciidoc")   
    @document.render(:html, "templates/html", "public/results/html")
    redirect "results/html/index.html"
  end
  
  get '/create_pdf' do
    
    args = []
    # Margins 0.75 inches bottom, left and right, not sure about top yet b/c of header
    args << { :option => "--margin-bottom", :value => 10 }
    args << { :option => "--margin-left", :value => 19.05 }
    args << { :option => "--margin-right", :value => 19.05 }
    
    # Page dimensions, 7.5x9.25 inches
    args << { :option => "--page-height", :value => 234.95 }
    args << { :option => "--page-width", :value => 190.5 }
    
    
    args << { :option => "--header-html", :value => "templates/print/views/header.html"}
    args << { :option => "--header-spacing", :value => 10} # make space between header and content
    args << { :option => "--margin-top", :value => 30} # the header spacing moves the header up, so push it down again
    
    @document = AsciiDoc::AsciiDocument.new("templates/test.asciidoc")
    @document.render(:pdf, "templates/print", "public/results/print", args)
    redirect "results/print/index.pdf"
  end

  not_found do
    erb :notfound
  end
  
end



