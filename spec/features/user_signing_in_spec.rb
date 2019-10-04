require 'rails_helper.rb'

feature "Sign in flow: " do
  scenario "User is signing in with correct data" do
    visit('/users/sign_in')

    fill_in 'user_login', with: 'john@example.com'
    fill_in 'user_password', with: 'sEcReT321'

    click_button 'Увійти'
    page.has_link?('Забули пароль?')
    page.has_link?('Не отримали інструкції підтвердження?')

    expect(page)
  end

  scenario "User is signing in without filling required information" do
    visit('/users/sign_in')

    click_button 'Увійти'
    page.has_link?('Забули пароль?')
    page.has_link?('Не отримали інструкції підтвердження?')

    expect(page).to have_content "Невірний email чи пароль"
  end
end
