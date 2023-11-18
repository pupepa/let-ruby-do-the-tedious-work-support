# frozen_string_literal: true

require "roo"

XLSX_FILE = "./input/24856_zaitaku_kintai_kanri.xlsx"

xlsx = Roo::Spreadsheet.open(XLSX_FILE)

sheet = xlsx.sheet("勤怠管理表")

date = sheet.cell("B", 5)
puts date

department = sheet.cell("I", 4)
puts department

name = sheet.cell("I", 5)
puts name

headers = ["日付", "曜日", "出勤／在宅", "始業時刻", "終業時刻", "休憩時間(h)", "実働時間", "備考"]
values = sheet.parse(header_search: headers).reject { |row| row["始業時刻"].nil? }

puts values
