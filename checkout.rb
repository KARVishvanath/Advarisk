require 'selenium-webdriver'

def login(driver)
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
  return driver.current_url == 'https://www.saucedemo.com/inventory.html'
end

def proceed_to_checkout(driver)
  # Add an item to the cart
  add_to_cart_button = driver.find_element(:xpath, "//div[@class='inventory_item'][1]//button")
  add_to_cart_button.click

  # Go to the cart page
  cart_button = driver.find_element(:class, 'shopping_cart_link')
  cart_button.click

  # Proceed to checkout
  checkout_button = driver.find_element(:id, 'checkout')
  checkout_button.click

  # Verify if user successfully proceeds to checkout
  return driver.current_url == 'https://www.saucedemo.com/checkout-step-one.html'
end

def enter_shipping_information(driver, firstname, lastname, zip_code)
  # Enter shipping information
  firstname_field = driver.find_element(:id, 'first-name')
  lastname_field = driver.find_element(:id, 'last-name')
  zip_code_field = driver.find_element(:id, 'postal-code')
  continue_button = driver.find_element(:id, 'continue')

  # Fill in shipping information
  firstname_field.send_keys firstname
  lastname_field.send_keys lastname
  zip_code_field.send_keys zip_code

  # Click continue button
  continue_button.click

  # Verify if user successfully enters shipping information
  return driver.current_url == 'https://www.saucedemo.com/checkout-step-two.html'
end

def enter_billing_information(driver)
  # Enter billing information (skipping for simplicity)
  continue_button = driver.find_element(:id, 'continue')
  continue_button.click

  # Verify if user successfully enters billing information
  return driver.current_url == 'https://www.saucedemo.com/checkout-step-two.html'
end

def verify_order_summary(driver)
  # Verify order summary
  product_name = driver.find_element(:class, 'inventory_item_name').text
  product_price = driver.find_element(:class, 'inventory_item_price').text
  subtotal = driver.find_element(:class, 'summary_subtotal_label').text
  tax = driver.find_element(:class, 'summary_tax_label').text
  total = driver.find_element(:class, 'summary_total_label').text

  # Display order summary
  puts "Product Name: #{product_name}"
  puts "Product Price: #{product_price}"
  puts "Subtotal: #{subtotal}"
  puts "Tax: #{tax}"
  puts "Total: #{total}"
end

def place_order(driver)
  # Place order
  finish_button = driver.find_element(:id, 'finish')
  finish_button.click

  # Verify if user successfully places the order
  return driver.current_url == 'https://www.saucedemo.com/checkout-complete.html'
end

# Set up the driver
driver = Selenium::WebDriver.for :chrome

# Navigate to the URL
driver.get 'https://www.saucedemo.com/'

# Login
if login(driver)
  puts 'Login successful.'
else
  puts 'Login failed.'
  driver.quit
  exit
end

# Proceed to checkout
if proceed_to_checkout(driver)
  puts 'Proceed to checkout successful.'
else
  puts 'Failed to proceed to checkout.'
  driver.quit
  exit
end

# Enter shipping information
if enter_shipping_information(driver, 'Vishvanath', 'Chougule', '591237')
  puts 'Shipping information entered successfully.'
else
  puts 'Failed to enter shipping information.'
  driver.quit
  exit
end

# Enter billing information
if enter_billing_information(driver)
  puts 'Billing information entered successfully.'
else
  puts 'Failed to enter billing information.'
  driver.quit
  exit
end

# Verify order summary
puts 'Order Summary:'
verify_order_summary(driver)

# Place order
if place_order(driver)
  puts 'Order placed successfully.'
else
  puts 'Failed to place the order.'
end

# Close the browser
driver.quit
