class WelcomeController < ApplicationController
  def index
    if params[:q]
      conn = Faraday.new(url: "https://od-api.oxforddictionaries.com") do |faraday|
                faraday.headers["app_key"] ="#{ENV["APP_KEY"]}"
                faraday.headers["app_id"] = "#{ENV["APP_ID"]}"
                faraday.adapter Faraday.default_adapter
              end

      response = conn.get("/api/v1/inflections/en/#{params[:q]}/grammaticalFeatures=singular")

      payload = JSON.parse(response.body, symbolize_names: true)

      binding.pry

      payload[:results].first[:lexicalEntries][1][:inflectionOf].first[:id]
    end

      @valid_word = if payload[:results]
                      return "'#{params[:q]}' is a valid word and its root form is #{payload[:results].first[:lexicalEntries][0][:inflectionOf].first[:id]}."
                    elsif !payload[:results]
                      return "'#{params[:q]}' is not a valid word."
                    end
  end
end
