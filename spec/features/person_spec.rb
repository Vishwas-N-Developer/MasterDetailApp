require 'rails_helper'

RSpec.feature "People", type: :feature do

  it "Index" do
    person1 = FactoryBot.create(:person)
    person2 = FactoryBot.create(:person)
    person3 = FactoryBot.create(:person)

    visit '/'

    within(:css, "#person_#{person1.id}") do
      expect(page).to have_text(person1.name)
      expect(page).to have_text(person1.detail.email)
    end

    within(:css, "#person_#{person2.id}") do
      expect(page).to have_text(person2.name)
      expect(page).to have_text(person2.detail.email)
    end

    within(:css, "#person_#{person3.id}") do
      expect(page).to have_text(person3.name)
      expect(page).to have_text(person3.detail.email)
    end
  end

  it "Create" do
    visit "/"

    page.click_link "Create new person"

    page.fill_in "Title", with: "Mr."
    page.fill_in "Name", with: "Tara McKenzie"
    page.fill_in "Email", with: "skoch@gmail.com"

    page.click_button "Create Person"
    expect(Person.count).to eq(1)
    
    within(:css, "#person_#{Person.last.id}") do
      expect(page).to have_text("Mr.")
      expect(page).to have_text("Tara McKenzie")
      expect(page).to have_text("skoch@gmail.com")
    end

    page.click_link "Create new person"
    
    page.fill_in "Title", with: "Mr."
    page.fill_in "Name", with: "Tara McKenzie"

    page.click_button "Create Person"

    expect(Person.count).to eq(1)
  end

  it "Edit" do
    person = FactoryBot.create(:person)

    visit '/'

    within(:css, "#person_#{person.id}") do
      click_link "Edit"

      page.fill_in "Name", with: "Janae Price"
      page.fill_in "Email", with: "spollich@gmail.com"

      page.click_button "Update Person"

      expect(page).to have_text("Janae Price")
      expect(page).to have_text("spollich@gmail.com")
      
      expect(page).not_to have_text("Tara McKenzie")
      expect(page).not_to have_text("skoch@gmail.com")

      click_link "Edit"

      page.fill_in "Email", with: ""
      page.click_button "Update Person"
    
      expect(Person.last.detail.email).not_to eq("")
    end
  end

  it "Delete" do
    person = FactoryBot.create(:person)
    
    visit '/'

    expect(page).to have_text(person.name)
    expect(page).to have_text(person.detail.email)

    within(:css, "#person_#{person.id}") do
      click_link "Delete"
    end

    expect(page).not_to have_text(person.name)
    expect(page).not_to have_text(person.detail.email)

  end
end
