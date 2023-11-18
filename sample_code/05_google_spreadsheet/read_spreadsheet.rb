# frozen_string_literal: true

require "google/apis/sheets_v4"

SERVICE_ACCOUNT_KEY_PATH = File.join(Dir.pwd, ".credentials", "your_service_key.json")

api = Google::Apis::SheetsV4::SheetsService.new
authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open(SERVICE_ACCOUNT_KEY_PATH),
  scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS
)

authorizer.fetch_access_token!
api.authorization = authorizer

SPREADSHEET_ID = ENV["SPREADSHEET_ID"]
values = api.get_spreadsheet_values(SPREADSHEET_ID, "シート1!A1:C3").values
pp values
# => [["ID", "名前", "年齢"], ["1", "Mike", "20"], ["2", "John", "30"]]

api.append_spreadsheet_value(
  SPREADSHEET_ID,
  "シート1!A6", { "values": [["We love Ruby!"]] },
  value_input_option: "RAW"
)
