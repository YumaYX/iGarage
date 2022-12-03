#!/usr/bin/env ruby

require 'selenium-webdriver'

class YSWebDriver

  attr_reader :driver
  attr_writer :url
  attr_writer :window_width, :window_height
  attr_reader :headless

  def initialize(url = '', headless = false)
    @url = url
    @headless = headless
    @window_width, @window_height = 800, 600
    prepareWebDriver
  end

  def accessUrl
    @driver.get(@url)
  end
  alias_method :hlAccessUrl, :accessUrl

  def hlGetContent
    @driver.page_source.encode('utf-8')
  end

  def saveScreenshot(image_path="screenshot.png")
    @driver.save_screenshot('./' + image_path)
  end

  private

  def prepareWebDriver
    if @headless == true then
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      @driver = Selenium::WebDriver.for :chrome, capabilities: [options]
    else
      @driver = Selenium::WebDriver.for :chrome
    end
    @driver.manage.window.resize_to(@window_width, @window_height)
  end

end

if __FILE__ == $0
  d = YSWebDriver.new('http://www.yahoo.co.jp')
  d.accessUrl
  sleep 1
  d.driver.navigate.to "https://google.com/"
  p d.driver.title
  sleep 1
  d.driver.close

  # headless
  d = YSWebDriver.new('http://www.yahoo.co.jp', true)
  d.accessUrl
  p d.hlGetContent
  d.driver.quit
end