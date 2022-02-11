require 'rails_helper'

RSpec.describe 'login', type: :feature do
  let(:user) { create(:user) }

  it 'Signs in user' do
    visit new_user_session_path
    expect(page).to have_content 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Receipts'
  end

  it 'Should not Sign user in if not valid' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(current_path).to eq('/users/sign_in')
  end
end

describe 'logout', type: :feature do
  let(:user) { create(:user) }

  it 'Signs out user' do
    visit new_user_session_path
    expect(page).to have_content 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(current_path).to eq root_path
    click_link 'Log out'
    expect(page).to have_content 'Log in'
  end
end
