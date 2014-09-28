OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '933220741598-et27aiq1ihu2l25a2jisihqmm2rr0h04.apps.googleusercontent.com', 'qZO0wN4yKG34I05egt2yfHsc', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end