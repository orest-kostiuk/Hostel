require 'rails_helper'

feature "Registration flow: " do
  scenario "User is signing up with correct data" do
    visit('/users/sign_up')
    fill_in 'user_login_code', with: '23232'
    fill_in 'user_email', with: 'john@example.com'
    fill_in 'user_password', with: 'sEcReT321'
    fill_in 'user[password_confirmation]', with: 'sEcReT321'

    click_button 'Зареєструватись'
    page.has_link?('Не отримали інструкції підтвердження?')

    expect(page).to have_content 'Ви отримаєте лист з інструкціями по підтвердженню вашого облікового запису протягом декількох хвилин.'
  end

  scenario "User is signing up without filling required information" do
    visit('/users/sign_up')

    click_button 'Зареєструватись'
    page.has_link?('Не отримали інструкції підтвердження?')

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end
end