Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ->(origin, _env) {
      origin =~ /https?:\/\/.*\.lvh\.me(:\d+)?$/ || 
      ['http://lvh.me:3000', 'http://127.0.0.1:3000', 'http://localhost:9000', 'http://localhost:8080', 'http://localhost:8081', 'http://lvh.me:9000'].include?(origin)
    }

    resource '*', 
      headers: :any, 
      methods: [:get, :post, :put, :patch, :delete, :options], 
      credentials: true
  end
end
