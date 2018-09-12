require 'rails_helper'

describe OxfordService do
  context "instance methods" do
    describe "#validate_word" do
      it "returns valid word" do
        VCR.use_cassette("oxford_service_word_validator") do
          word = "foxes"
          os = OxfordService.new(word)
          word_response = os.validate_word

          expect(word_response).to have_key(:results)
        end
      end

      it "returns invalid word" do
       VCR.use_cassette("oxford_service_word_validator_invalid") do
         word = "fozes"
         os = OxfordService.new(word)
         word_response = os.validate_word

         expect(word_response).to eq(false)
       end
      end
    end
  end
end
