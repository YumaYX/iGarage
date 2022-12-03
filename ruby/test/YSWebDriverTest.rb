require 'minitest/autorun'
require_relative './../lib/YSWebDriver'

class YSWebDriverTest < Minitest::Test

  def setup
    url = 'https://github.com/YumaYX/RubyBox'
    @wd_hl = YSWebDriver.new(url, true)
    @wd = YSWebDriver.new(url, false)
  end

  def test_getWebPageTitle
    @wd_hl.accessUrl
    assert_equal('GitHub - YumaYX/RubyBox', @wd_hl.driver.title)
    @wd_hl.driver.quit

    @wd.accessUrl
    assert_equal('GitHub - YumaYX/RubyBox', @wd.driver.title)
    @wd.driver.quit
  end
end