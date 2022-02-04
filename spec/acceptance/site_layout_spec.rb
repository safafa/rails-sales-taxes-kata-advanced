require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  let(:user) { create(:user) }

  context 'When user is not logged in' do
    before do
      visit root_path
    end
    it { expect(page).to have_content 'Sign up' }
    it { expect(page).to have_content 'Log in' }
    it { expect(page).to have_css '.image' }
  end

  context 'When user is logged in' do
    before do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
    it { expect(page).to have_content 'Receipts' }
    it { expect(page).to have_content 'New receipt' }
  end
end
