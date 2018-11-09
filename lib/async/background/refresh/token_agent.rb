require 'async/background/refresh/version'
require 'async/background/refresh/token'
require 'concurrent'

module Async
  module Background
    module Refresh
      class TokenAgent
        def initialize
          cache_token(Token.new)
        end

        def token
          maybe_token = cached_token
          return maybe_token if maybe_token
          puts 'fetching new token as current token wasnt found'
          cache_token(Token.new)
        end

        private

        def cached_token
          @@token.valid? ? @@token : nil
        end

        def cache_token(new_token)
          @@token = new_token
          schedule_token_refresh
          @@token
        end

        def schedule_token_refresh
          puts 'scheduled background task'
          time_to_refresh = ((@@token.expiration_time - Time.now) * 0.75).floor
          cache_token(oken.new) && return if time_to_refresh < 0
          Concurrent::ScheduledTask.execute(time_to_refresh) do
            puts 'fetched token in the background'
            cache_token(Token.new)
          end
        end
      end
    end
  end
end
