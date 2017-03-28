require 'yaml'
require 'optparse'

module PostImagesBot
  class Configuration

    attr_accessor :configuration

    def initialize
      @options = {}
      @configuration = {}
    end

    def parse_command_line(argv)
      parser = OptionParser.new

      parser.banner = "Usage: #{$PROGRAM_NAME} -c <file>

Post images to Twitter, according to configuration in <file>"

      parser.separator ''
      parser.on('-c FILE', '--config FILE',
                'configuration file', String) { |file|
                 @options[:config_file] = file }
      parser.on_tail('-h', '--help', 'display usage information') {
                      raise ArgumentError }

      parser.parse!(argv)
    end

    def read_configuration
      @configuration = YAML.load_file(@options[:config_file])
    end
  end
end
