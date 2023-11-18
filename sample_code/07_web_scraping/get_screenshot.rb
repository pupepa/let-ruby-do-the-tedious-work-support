# frozen_string_literal: true

require "ferrum"

URL = "https://www.ruby-lang.org/ja/news/"

browser = Ferrum::Browser.new
browser.go_to(URL)

# スクリーンショットを取得する
browser.screenshot(path: "screenshot.png", full: true)

browser.quit
