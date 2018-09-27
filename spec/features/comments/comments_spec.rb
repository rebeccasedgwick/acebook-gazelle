require "rails_helper"
require "web_helper"

RSpec.feature "Comments can be made on posts", type: :feature do
  before(:each) do
    user_sign_up
    submit_test_post
    # visit root_path
  end

  scenario "Post is not liked before button clicked" do
    expect(page).not_to have_content("Bob: ")
  end

  scenario "Comment made on post is visible" do
    add_comment("This is a comment")
    # click_on "Comment"
    expect(page).to have_content("Bob: This is a comment")
  end

  scenario "Comments can be made on a single post by multiple people" do
    add_comment("This is a comment")
    click_on "Sign out"
    user_sign_up("Jim")
    add_comment("This is Jim's comment")
    expect(page).to have_content("Bob: This is a comment")
    expect(page).to have_content("Jim: This is Jim's comment")
  end

  scenario "Comments are visible on timeline page" do
    visit root_path
    add_comment("This is a comment")
    expect(page).to have_content("Bob: This is a comment")
  end

end
