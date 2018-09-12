require "rails_helper"

describe "as a guest user" do
  describe "when I visit /" do
    it "fills in a text box with foxes and clicks validate word" do
      visit "/"

      fill_in :q, with: "foxes"
      click_on "Validate Word"

      expect(page).to have_content("'foxes' is a valid word and its root form is 'fox'")
    end
  end

  it "fills in a text box with foxez and clicks validate word" do
    visit "/"

    fill_in :q, with: "foxez"
    click_on "Validate Word"

    expect(page).to have_content("'foxez' is not a valid word.")
  end
end
