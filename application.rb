require 'rubygems'
require 'bundler'
Bundler.require
require './helpers/magicrocco'
require './helpers/codepostprocessing'

class Application < Sinatra::Base

  get '/' do
    erb :front
  end

  get '/create_html/*' do
    asciidoc_file = "/" + params[:splat][0]
    output_folder = File.join(File.dirname(asciidoc_file), "noc_html")
    
    @document = AsciiDoc::AsciiDocument.new(asciidoc_file, {:debug_xml_to_file => File.join(output_folder, "index.xml") })
    @document.render(:html, :template => File.join(output_folder, "views"), :output => File.join(output_folder, "index.html"))
    
    "Done!"
  end
  
  get '/create_html_chapters/*' do
    asciidoc_file = "/" + params[:splat][0]
    output_folder = File.join(File.dirname(asciidoc_file), "noc_html")
    
    @document = AsciiDoc::AsciiDocument.new(asciidoc_file, {:debug_xml_to_file => File.join(output_folder, "index.xml") })
    @document.render(:html_chapters, :template => File.join(output_folder, "views"), :output => File.join(output_folder, "index.html"))
    
    "Done!"
  end

  get '/create_pdf/*' do
    
    asciidoc_file = "/" + params[:splat][0]
    output_folder = File.join(File.dirname(asciidoc_file), "noc_pdf")

    startTime = Time.now
    puts "///////// Starting Render: #{startTime}"

    # create asciidocument
    @document = AsciiDoc::AsciiDocument.new(asciidoc_file, { :debug_xml_to_file => File.join(output_folder, "index.xml") })
    puts "Parsed Asciidoc after: #{Time.now-startTime} seconds"

    #render html
    @document.render(:html, :template => File.join(output_folder, "views"), :output => File.join(output_folder, "index.html"))
    puts "Rendered HTML after: #{Time.now-startTime} seconds"
    
    # render page count pdf
    @document.render(:pdf,  :html_file => File.join(output_folder, "index.html"), 
                            :output => File.join(output_folder, "page_count.pdf"),
                            :prince_args => [
                              ["--script", File.join(output_folder, "page_count", "page_count.js")], 
                              ["--style", File.join(output_folder, "page_count", "page_count.css")], 
                              ["-i", "html5"],
                              [">", File.join(output_folder, "page_count", "out.js")]
                            ]
    )
    puts "Rendered Page Count PDF after: #{Time.now-startTime} seconds"

    #render final pdf
    @document.render(:pdf,  :html_file => File.join(output_folder, "index.html"), 
                            :output => File.join(output_folder, "index.pdf"),
                            :prince_args => [
                              ["--script", File.join(output_folder, "page_count", "page_filter.js")], 
                              ["--script", File.join(output_folder, "page_count", "out.js")], 
                              "--verbose",
                              ["-i", "html5"]
                            ]
    )
    puts "Rendered PDF after: #{Time.now-startTime} seconds"

    "Done in in: #{Time.now-startTime} seconds"
  end

  not_found do
    erb :notfound
  end

end



