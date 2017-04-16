require 'post_images_bot/configuration'
require 'twitter'

module PostImagesBot
  # The main bot interface.
  class PostImagesBot
    def initialize(configuration)
      @configuration = configuration
    end

    def sufficient_time_elapsed?
      Time.now.to_i > @configuration.last_post +
                      @configuration.min_interval
    end

    def twitter_login
      @twitter_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = @configuration.consumer_key
        config.consumer_secret     = @configuration.consumer_secret
        config.access_token        = @configuration.access_token
        config.access_token_secret = @configuration.access_secret
      end
    end

    # Post a tweet, using the specified text and attaching the
    # specified image. Returns the URL of the posted tweet.
    def post_image(text, image_file_name)
      @twitter_client.update_with_media(text, File.new(image_file_name)).url
    end

    # Run one iteration of the bot: check that sufficient time has
    # elapsed, and if so, post the next image. Returns the updated
    # configuration with the timestamp and tweet URL filled in.
    def run
      return @configuration unless sufficient_time_elapsed?

      twitter_login

      # Find the first image in the list that doesn't have a URL, and
      # thus hasn't been posted.
      image = @configuration.images.find { |i| i['post'].nil? }

      image['post'] = post_image(image['text'], image['file'])

      @configuration.last_post = Time.now.to_i

      @configuration
    end
  end
end
