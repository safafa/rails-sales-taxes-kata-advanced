module Features
  def upload_baskets(number)
    number.times do
      visit '/baskets/new'
      page.attach_file('file', 'baskets/basket_2.txt')
      click_button('submit')
    end
  end
end
