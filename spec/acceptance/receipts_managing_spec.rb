require 'rails_helper'

RSpec.describe 'Receipts managing', type: :feature do
  context 'when user logged in' do
    it 'Upload basket and prints receipt' do
      visit root_path
      click_link('New receipt')
      page.attach_file('file', 'baskets/basket_2.txt')
      expect(page).to have_content '1 imported bottle of perfume : 54.65'
      expect(page).to have_content 'Sales taxes : 7.65'
      expect(page).to have_content 'Total: 65.15'
    end

    it 'Displays receipts history' do
      visit root_path
      click_link('Receipts')
      expect(page).to have_content 'Receipts History'
      expect(page).to have_css '.receipts li'
      expect(page).to have_css '.receipts li .link', text: 'show'
    end
  end
end
