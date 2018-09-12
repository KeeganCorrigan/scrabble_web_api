require "rails_helper"

describe WordPresenter do
  describe "#instance methods" do
    describe "#validate_word" do
      it "validates word in oxford dictionary API" do
        wp = WordPresenter.new("foxes")

        expect(wp.validate_word).to eq("'foxes' is a valid word and its root form is 'fox'.")
      end

      it "invalidates an incorrect word" do
        wp = WordPresenter.new("foxez")

        expect(wp.validate_word).to eq("'foxez' is not a valid word.")
      end
    end
  end
end
