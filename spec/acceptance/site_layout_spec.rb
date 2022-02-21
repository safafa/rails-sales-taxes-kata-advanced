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
      sign_in(user)
    end
    it { expect(page).to have_content 'Receipts' }
    it { expect(page).to have_content 'New receipt' }
    it { expect(page).to have_content 'Log out' }
  end
end
