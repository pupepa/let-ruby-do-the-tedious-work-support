# frozen_string_literal: true

require "ferrum"

URL = "https://www.ruby-lang.org/ja/news/"

browser = Ferrum::Browser.new
browser.go_to(URL)

# 最新のニュースのタイトルを取得
puts browser.xpath('//div[@id="content"]/div/h3/a').map(&:text)

browser.quit
