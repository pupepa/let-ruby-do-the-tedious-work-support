# frozen_string_literal: true

require "ferrum"

URL = "https://www.ruby-lang.org/ja/downloads/"

browser = Ferrum::Browser.new(save_path: File.expand_path("./downloads"))
browser.go_to(URL)

link = browser.at_xpath('//div[@id="content"]/ul[2]/li/ul/li/a').attribute("href")
browser.go_to(link)
