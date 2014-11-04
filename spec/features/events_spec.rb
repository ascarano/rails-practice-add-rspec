require 'rails_helper'

feature "Events" do

    visit root_path
    click_on "New Event"
    fill_in "Description", with: "My awesome event"
    click_on "Create Event"

    expect(page).to have_content("My awesome event")

end
