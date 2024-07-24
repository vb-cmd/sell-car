require 'rails_helper'

RSpec.describe 'Ads::Cars', type: :system do
  fixtures(:all)

  before do
    driven_by(:selenium_chrome)
    @car = cars(:ford4)
  end

  before do
    visit ads_cars_path
  end

  describe 'Search' do
    it 'should find car' do
      fill_in 'car[make_cont_any]', with: @car.make

      click_button('Send')

      expect(page).to have_content("#{@car.make} #{@car.model}")
    end
  end

  describe 'Pagination' do
    it 'should turn the page' do
      xpath_pages = '/html/body/div/div[3]/div[1]/div/nav/ul'

      page.find(:xpath, xpath_pages, text: '2').click
      
      expect(page).to have_css('.page-item.active', text: 2)
    end
  end
end
