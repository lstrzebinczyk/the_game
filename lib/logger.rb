require "pathname"
require "fileutils"

class Logger
  def self.log(content)
    Pathname.new(FileUtils.pwd).join("lib/log").open("w+") do |file|
      file.write content.inspect
      file.write "\n"
    end
  end
end
