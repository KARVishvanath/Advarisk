require 'selenium-webdriver'

# Set up Selenium WebDriver
driver = Selenium::WebDriver.for :chrome
driver.manage.window.maximize

# Test Case: Valid Login Credentials
# Steps:
# 1. Launch the application and navigate to the login page.
# 2. Enter a valid username and password.
# 3. Click on the "Login" button.
# 4. Verify that the user is successfully logged in and directed to the home page.

# 1. Navigate to the login page
driver.get 'https://www.saucedemo.com/'

# 2. Enter valid username and password
username_field = driver.find_element(:id, 'user-name')
password_field = driver.find_element(:id, 'password')

username_field.send_keys 'standard_user'
password_field.send_keys 'secret_sauce'

# 3. Click on the "Login" button
login_button = driver.find_element(:id, 'login-button')
login_button.click

# 4. Verify that the user is successfully logged in and directed to the home page
# Assuming there's an element on the home page to verify
home_page_title = driver.find_element(:id, 'shopping_cart_container')
if home_page_title.display == true
  puts 'User is successfully logged in and on the home page.'
else
  puts 'Login failed. User is not on the home page.'
end

# Test Case: Invalid Login Credentials
# Steps:
# 1. Launch the application and navigate to the login page.
# 2. Enter an invalid username and password combination.
# 3. Click on the "Login" button.
# 4. Verify that an error message is displayed indicating that the login credentials are incorrect.

# 1. Navigate to the login page
driver.get 'https://www.saucedemo.com/'

# 2. Enter invalid username and password
username_field = driver.find_element(:id, 'user-name')
password_field = driver.find_element(:id, 'password')

username_field.send_keys 'invalid_standard_user'
password_field.send_keys 'invalid_secret_sauce'

# 3. Click on the "Login" button
login_button = driver.find_element(:id, 'login-button')
login_button.click

# 4. Verify that an error message is displayed indicating that the login credentials are incorrect
# Assuming there's an element to display the error message
error_message = driver.find_element(:xpath, "//*[@class = 'error-message-container error']//h3"
if error_message.text == "Epic sadface: Username and password do not match any user in this service"
  puts 'Username and password do not match error message is displayed.'
else
  puts 'Username and password do not match error message is not displayed.'
end

# Clean up
driver.quit
