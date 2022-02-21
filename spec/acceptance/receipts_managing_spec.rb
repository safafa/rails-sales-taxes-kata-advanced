require 'rails_helper'

RSpec.describe 'Receipts managing', type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user, email: 'otheruser@example.com') }
  before do
    sign_in(user)
  end
  context 'when user logged in' do
    it 'Uploads basket and prints receipt' do
      upload_baskets(1)
      expect(page).to have_content '1 imported bottle of perfume : 54.65'
      expect(page).to have_content 'Sales taxes : 7.65'
      expect(page).to have_content 'Total: 65.15'
    end

    it 'Displays receipts history of the current_user' do
      upload_baskets(6)
      visit '/baskets'
      expect(page).to have_content 'Receipts History'
      expect(page).to have_css 'div.pagination'
      expect(page).to have_css '.btn', text: 'Add'
      click_link('Log out')
      sign_in(other_user)
      click_link('Receipts')
      expect(page).not_to have_css '.list-group-item', text: 'Receipt'
    end
  end
end
