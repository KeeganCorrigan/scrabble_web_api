class OxfordService
  def initialize(word)
    @conn = Faraday.new(url: "https://od-api.oxforddictionaries.com") do |faraday|
              faraday.headers["app_key"] ="#{ENV["APP_KEY"]}"
              faraday.headers["app_id"] = "#{ENV["APP_ID"]}"
              faraday.adapter Faraday.default_adapter
            end
    @word = word
  end

  def validate_word
    get_url("/api/v1/inflections/en/#{@word}")
  end

  private

  def get_url(url)
    response = @conn.get(url)
    unless response.body.include?("Not Found")
      JSON.parse(response.body, symbolize_names: true)
    else
      return false
    end
  end
end
