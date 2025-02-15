# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin

# Read more : https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_ibefore 0, Rack::Cors do
    allow do
        origins "http://localhost:3000"

        resource "*",
          headers: :any,
          expose: ["Authorization"]
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
end          