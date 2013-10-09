module Capybara
  class Session
    def has_notice?(text)
      has_xpath? "//div[@id='flash_container']//div[@class='alert alert-success' and text()=\"#{text}\"]"
    end
    def has_error?(text)
      has_xpath? "//div[@id='flash_container']//div[@class='alert alert-error' and text()=\"#{text}\"]"
    end
  end
end