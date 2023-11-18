# frozen_string_literal: true

require "pdf-reader"

# 給与明細書のPDFファイルから差引支給額を取得する
def net_payment(pdf)
  reader = PDF::Reader.new(pdf)
  text = reader.page(1).text
  text.split("\n")[6].match(/\\([\d,]+)/)[1].gsub(",", "").to_i
end

amount_net_payment = 0 # 合計額を管理する変数
Dir.glob("./input/給与明細書*.pdf").each do |pdf|
  amount_net_payment += net_payment(pdf)
end

puts amount_net_payment
