require 'patho_roster'
require 'rack/offline'

map "/application.manifest" do
  offline = Rack::Offline.new :cache => true, :root => "public" do
    # Cache all files under the directory public
    Dir[File.join(settings.public, "**/*")].each do |file|
      cache file.sub(File.join(settings.public, ""), "")
    end

    # All other files should be downloaded
    network '/'
  end

  run offline
end

map "/" do
  run Sinatra::Application
end

