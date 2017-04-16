require 'yaml'
require 'optparse'

module PostImagesBot
  # Encapsulates the configuration of the bot, including reading and
  # writing configuration files.
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
                 'configuration file', String) do |file|
        @options[:config_file] = file
      end
      @parser.on_tail('-h', '--help', 'display usage information') do
        abort(usage)
      end

      @parser.parse!(argv)
    end

    def read_configuration
      if @options[:config_file]
        @configuration = YAML.load_file(@options[:config_file])
      else
        abort(usage)
      end
    end

    # Borrowed from ruby-2.4.1/lib/pstore.rb:
    # save_data_with_atomic_file_rename_strategy
    def atomic_write(data, filename)
      temp_filename = "#{filename}.tmp.#{Process.pid}.#{rand 1_000_000}"
      temp_file = File.new(temp_filename, File::CREAT | File::EXCL | File::RDWR)
      begin
        temp_file.flock(File::LOCK_EX)
        temp_file.write(data)
        temp_file.flush
        File.rename(temp_filename, filename)
      rescue
        File.unlink(temp_filename) rescue nil
        raise
      ensure
        temp_file.close
      end
    end

    def write_configuration
      atomic_write(@configuration.to_yaml, @options[:config_file])
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

    def consumer_key
      @configuration['credentials']['consumer_key']
    end

    def consumer_secret
      @configuration['credentials']['consumer_secret']
    end

    def access_token
      @configuration['credentials']['access_token']
    end

    def access_secret
      @configuration['credentials']['access_secret']
    end

    def images
      @configuration['images']
    end
  end
end
