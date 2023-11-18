# frozen_string_literal: true

require "pdf-reader"

PDF_FILE = "./input/給与明細書.pdf"

reader = PDF::Reader.new(PDF_FILE)
text = reader.page(1).text
value = text.split("\n")[6].match(/\\([\d,]+)/)[1].gsub(",", "").to_i

puts value
