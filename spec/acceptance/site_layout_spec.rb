require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  before do
    visit root_path
  end
  context 'When user not logged in' do
    it { expect(page).to have_content 'Sign up' }
    it { expect(page).to have_content 'login' }
    it { expect(page).to have_css '.image' }
  end

  context 'When user is logged in' do
    it { expect(page).to have_content 'Receipts' }
    it { expect(page).to have_content 'New receipt' }
  end
end
