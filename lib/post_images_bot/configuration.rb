require 'yaml'
require 'optparse'

module PostImagesBot
  class Configuration

    attr_accessor :configuration
    attr_accessor :parser

    def initialize
      @options = {}
      @configuration = {}
      @parser = OptionParser.new
    end

    # Usage information from option parser
    #
    # Example:
    #
    #   abort(usage) unless options[:warehouse]

    def usage
      @parser.to_s
    end

    def parse_command_line(argv)
      @parser.banner = "Usage: #{$PROGRAM_NAME} -c <file>

Post images to Twitter, according to configuration in <file>"

      @parser.separator ''
      @parser.on('-c FILE', '--config FILE',
                 'configuration file', String) { |file|
                 @options[:config_file] = file }
      @parser.on_tail('-h', '--help', 'display usage information') {
        abort(usage) }

      @parser.parse!(argv)
    end

    def read_configuration
      if @options[:config_file]
        @configuration = YAML.load_file(@options[:config_file])
      else
        abort(usage)
      end
    end

    # Virtual accessors for important configuration values

    def last_post
      @configuration['timing']['last_post']
    end

    def last_post=(timestamp)
      @configuration['timing']['last_post'] = timestamp
    end

    def min_interval
      @configuration['timing']['min_interval']
    end
  end
end
