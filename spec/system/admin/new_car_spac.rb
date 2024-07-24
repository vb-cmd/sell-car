require 'rails_helper'

RSpec.describe 'Admin::Dashboards::Cars', type: :system do
  fixtures(:all)

  before do
    driven_by(:selenium_chrome)
    @admin = admin_users(:admin)
    @user = users(:vitalii)
  end

  before do
    admin_user_login_system(@admin.email, 'password')
  end

  describe 'New car' do
    before do
      visit admin_dashboards_cars_path
    end

    it 'should show form for creating new car' do
      click_link 'New'

      expect(page).to have_content('New car')
    end

    it 'should create new car' do
      click_link 'New'

      fill_in 'car[make]', with: 'test make'
      fill_in 'car[model]', with: 'test model'
      fill_in 'car[body_type]', with: 'test body_type'
      fill_in 'car[mileage]', with: '10000'
      fill_in 'car[color]', with: 'test color'
      fill_in 'car[price]', with: '20000'
      fill_in 'car[fuel_type]', with: 'test fuel_type'
      fill_in 'car[year]', with: '2000'
      fill_in 'car[engine_volume]', with: 'test engine_volume'
      select 'approved', from: 'car[status]'
      select @user.name, from: 'car[user_id]'
      attach_file 'car[image]', Rails.root.join('spec/fixtures/files/black.jpg')

      click_button('Send')

      expect(page).to have_content('Car was successfully created.')

      expect(page).to have_content('test make test model')
    end
  end
end