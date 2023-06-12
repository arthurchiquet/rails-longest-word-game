require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector ".p-3", count: 10
  end

  test "return word is not in the grid if random word" do
    visit new_url
    fill_in "word", with: "apple"
    click_on "Send"

    assert_text "not in the grid"
  end

  test "1 consonness" do
    visit new_url
    fill_in "word", with: "v"
    click_on "Send"

    assert_text "not an english word"
  end

end
