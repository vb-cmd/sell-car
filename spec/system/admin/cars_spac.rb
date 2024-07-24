require 'rails_helper'

RSpec.describe 'Admin::Dashboards::Cars', type: :system do
  fixtures(:all)

  before do
    driven_by(:selenium_chrome)
    @admin = admin_users(:admin)
  end

  before do
    admin_user_login_system(@admin.email, 'password')
  end

  describe 'Status' do
    before do
      visit admin_dashboards_cars_path
    end

    it 'should show all cars' do
      expect(page).to have_content('Cars')
    end

    it 'should switch to pending' do
      click_link 'Pending'

      expect(page).to have_content('Cars pending')
    end

    it 'should switch to rejected' do
      click_link 'Rejected'

      expect(page).to have_content('Cars rejected')
    end

    it 'should switch to approved' do
      click_link 'Approved'

      expect(page).to have_content('Cars approved')
    end
  end
end
