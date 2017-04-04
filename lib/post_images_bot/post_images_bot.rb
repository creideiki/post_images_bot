module PostImagesBot
  class PostImagesBot
    def initialize(configuration)
      @configuration = configuration
    end

    def sufficient_time_elapsed?
      Time.now.to_i > @configuration.last_post +
                      @configuration.min_interval
    end
  end
end
