require 'rails_helper'

RSpec.describe 'Receipts managing', type: :feature do
  let(:user) { create(:user) }
  before do
    sign_in(user)
  end
  context 'when user logged in' do
    let(:filepath) { Rails.root.join('baskets', 'basket_2.txt') }
    let(:file) { Rack::Test::UploadedFile.new(filepath, 'txt') }
    let(:basket) { create(:basket, user: user) }

    it 'Upload basket and prints receipt' do
      visit root_path
      click_link('New receipt')
      page.attach_file('file', 'baskets/basket_2.txt')
      click_button('submit')
      expect(page).to have_content '1 imported bottle of perfume : 54.65'
      expect(page).to have_content 'Sales taxes : 7.65'
      expect(page).to have_content 'Total: 65.15'
    end

    it 'Displays receipts history of the current_user' do
      basket.build_entries_from_file_upload(file)
      visit root_path
      click_link('Receipts')
      expect(page).to have_content 'Receipts History'
      expect(page).to have_css '.list-group-item', text: 'Receipt'
      expect(page).to have_css '.btn', text: 'Add'
    end
  end
end
