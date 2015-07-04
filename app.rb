require 'sinatra'
require 'pathname'

set :bind, '0.0.0.0'

set :root, File.dirname(__FILE__)

class ImLazyApp < Sinatra::Base
  get "/" do
    # add <%= @links %> to the index.erb
    # dir = "./files/"
    # @links = Dir[dir+"*"].map {|file|
    #   file_link(file)
    # }.join
    # and uncomment the above

    @plexdownloadstv = plexdownloadstv
    @plexdownloadsmovie = plexdownloadsmovie
    erb :index
  end

  get "/refreshdownloadstv" do
    `curl --silent "http://10.0.1.11:32400/library/sections/6/refresh"`
    erb :refresh
  end

  get "/refreshdownloadsmovie" do
    `curl --silent "http://10.0.1.11:32400/library/sections/4/refresh"`
    erb :refresh
  end

  helpers do

    def plexdownloadstv
      "<li><a href='/refreshdownloadstv' target='_self'>Refresh Plex Downloads TV</a></li>"
    end

    def plexdownloadsmovie
      "<li><a href='/refreshdownloadsmovie' target='_self'>Refresh Plex Downloads Movies</a></li>"
    end

    def file_link(file)
      filename = Pathname.new(file).basename
      "<li><a href='#{file}' target='_self'>#{filename}</a></li>"
    end

  end
end
