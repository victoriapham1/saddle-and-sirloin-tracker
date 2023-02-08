require 'rails_helper'

RSpec.describe 'Creating a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in "book[title]", with: 'twilight'
    fill_in "book[author]", with: 'Stephenie Meyer'
    fill_in "book[price]", with: '1.99'
    fill_in "book[publishedDate]", with: '2019-09-09 00:00:00 UTC'
    click_on 'Create Book'
    visit books_path
    expect(page).to have_content('twilight')
  end
end