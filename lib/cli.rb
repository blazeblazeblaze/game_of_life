require 'optparse'

module Cli
  Configuration = Struct.new(:rows, :columns)

  def self.parse
    conf = Configuration.new
    parser = opt_parser(conf)

    parser.parse!

    raise OptionParser::MissingArgument, '-r' unless conf.rows
    raise OptionParser::MissingArgument, '-c' unless conf.columns

    conf
  rescue OptionParser::InvalidOption, OptionParser::MissingArgument
    puts parser
    exit
  end

  def self.opt_parser(conf)
    OptionParser.new do |parser|
      parser.banner = "Usage: game [options]"

      parser.on("-r", "--rows ROWS_COUNT", "Provide number of rows", OptionParser::OctalInteger) do |rows|
        conf.rows = rows
      end

      parser.on("-c", "--c COLUMNS_COUNT", "Provide number of columns", OptionParser::OctalInteger) do |columns|
        conf.columns = columns
      end

      parser.on("-h", "--help", "Prints this help") do
        puts parser
        exit
      end
    end
  end
end
