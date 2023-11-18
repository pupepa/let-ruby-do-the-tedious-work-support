# frozen_string_literal: true

require "fileutils"

def generate_destination_dir(path)
  birath_time = File.birthtime(path)

  "#{birath_time.year}-#{format("%02d", birath_time.month)}"
end

SOURCE_DIR = File.expand_path(File.join(__dir__, "source"))
DEST_DIR = File.expand_path(File.join(__dir__, "dest"))

unless File.directory?(SOURCE_DIR)
  puts "source directory is not found"
  exit 1
end

unless File.directory?(DEST_DIR)
  puts "destination directory is not found"
  exit 1
end

Dir.children(SOURCE_DIR).each do |file|
  source = File.join(SOURCE_DIR, file)
  dest = File.join(DEST_DIR, generate_destination_dir(source))

  FileUtils.mkdir_p(dest)
  FileUtils.mv(source, dest)
end
