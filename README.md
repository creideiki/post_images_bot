# post-images-bot

Twitter bot for posting a series of images, with comments, at set
intervals.

Configuration is read from a YAML file with the following structure:

```yaml
credentials:
  consumer_key: your consumer key
  consumer_secret: your consumer secret
  access_token: your access token
  access_secret: your access secret
timing:
  min_interval: minimum number of seconds between posts
  last_post: UNIX timestamp, filled in by the bot with the time of the last post
images:
  - file: file name of image 1
    text: text to post with image 1
    post: URL of the tweet, filled in by the bot when image 1 has been posted
  - file: file name of image 2
    text: text to post with image 2
    post: URL of the tweet, filled in by the bot when image 2 has been posted
...
```

Requires the https://github.com/sferik/twitter library.
