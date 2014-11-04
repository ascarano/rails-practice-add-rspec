require 'rails_helper'

feature "Events" do

  scenario "User cruds Event" do

    visit root_path
    click_on "New Event"
    fill_in "Description", with: "My awesome event"
    fill_in "Location", with: "Somewhere"
    fill_in "Capacity", with: 10
    check 'Requires ID'
    page.find_field('Date').set(Date.today - 1.month)
    click_on "Create Event"

    save_and_open_page
    expect(page).to have_content("My awesome event")
    expect(page).to have_content("Somewhere")
    expect(page).to have_content("2014-10-04")
    expect(page).to have_content(10)
    expect(page).to have_content("true")

    click_on "edit"

    fill_in "Description", with: "My unawesome event"
    fill_in "Location", with: "Somewhere Else"
    fill_in "Capacity", with: 11
    uncheck 'Requires ID'
    page.find_field('Date').set(Date.today)
    click_on "Update Event"

    save_and_open_page
    expect(page).to have_content("My unawesome event")
    expect(page).to have_content("Somewhere Else")
    expect(page).to have_content("2014-11-04")
    expect(page).to have_content(11)
    expect(page).to have_content("false")

    click_on "My unawesome event"
    click_on "Show all events"

    click_on "My unawesome event"
    click_on "Edit"

    fill_in "Description", with: "My super awesome event"
    fill_in "Location", with: "Somewhere Elsewhere"
    fill_in "Capacity", with: 12
    check 'Requires ID'
    page.find_field('Date').set(Date.today - 2.month)
    click_on "Update Event"

    expect(page).to have_content("My super awesome event")
    expect(page).to have_content("Somewhere Elsewhere")
    expect(page).to have_content("2014-09-04")
    expect(page).to have_content(12)
    expect(page).to have_content("true")

    click_on "delete" #failure occurs here!

    expect(page).to have_no_content("My super awesome event")
    expect(page).to have_no_content("Somewhere Elsewhere")
    expect(page).to have_no_content("2014-09-04")
    expect(page).to have_no_content(12)
    expect(page).to have_no_content("true")

  end

end
