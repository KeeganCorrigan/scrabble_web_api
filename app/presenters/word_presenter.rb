class WordPresenter
  def initialize(word)
    @oxford_service =  OxfordService.new(word)
    @word = word
  end

  def validate_word
    payload = @oxford_service.validate_word
    binding.pry
    if payload[:results]
      return "'#{@word}' is a valid word and its root form is '#{payload[:results].first[:lexicalEntries][0][:inflectionOf].first[:id]}'."
    else
      return "'#{@word}' is not a valid word."
    end
  end
end
