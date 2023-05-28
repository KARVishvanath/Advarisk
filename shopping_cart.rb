require 'selenium-webdriver'

# Set up the driver
driver = Selenium::WebDriver.for :chrome

# Navigate to the URL
driver.get 'https://www.saucedemo.com/'

# Find the username and password fields and login button
username_field = driver.find_element(:id, 'user-name')
password_field = driver.find_element(:id, 'password')
login_button = driver.find_element(:id, 'login-button')

# Enter the username and password
username_field.send_keys 'standard_user'
password_field.send_keys 'secret_sauce'

# Click the login button
login_button.click

# Verify successful login
if driver.current_url == 'https://www.saucedemo.com/inventory.html'
  puts 'Login successful.'
else
  puts 'Login failed.'
end

# Add an item to the cart
add_to_cart_button = driver.find_element(:xpath, "//div[@class='inventory_item'][1]//button")
add_to_cart_button.click

# Go to the cart page
cart_button = driver.find_element(:class, 'shopping_cart_link')
cart_button.click

# Verify item in the cart
if driver.find_element(:class, 'inventory_item_name').text == 'Sauce Labs Backpack'
  puts 'Item added to the cart successfully.'
else
  puts 'Failed to add item to the cart.'
end

# Close the browser
driver.quit
