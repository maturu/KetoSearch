if ENV['RACK_ENV'] == 'production'
  KetoSearch::Application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    r301 %r{.*}, 'https://www.ketosearch.org$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] == 'keto-search.herokuapp.com'
    }
  end
end
