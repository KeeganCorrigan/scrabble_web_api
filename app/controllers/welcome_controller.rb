class WelcomeController < ApplicationController
  def index
    conn = Faraday.new(url: "https://od-api.oxforddictionaries.com") do |faraday|
              faraday.headers["app_key"] ="#{ENV["APP_KEY"]}"
              faraday.headers["app_id"] = "#{ENV["APP_ID"]}"
              faraday.adapter Faraday.default_adapter
            end

    response = conn.get("https://od-api.oxforddictionaries.com:443/api/v1/inflections/en/#{}")


  end
end
