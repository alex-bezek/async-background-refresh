require "async/background/refresh/version"
require 'securerandom'

module Async
  module Background
    module Refresh
      class Token
        attr_reader :expiration_time, :value

        def initialize
          sleep 5
          @expiration_time = Time.now + 10
          @value = SecureRandom.uuid
        end

        def valid?
          @expiration_time > Time.now
        end
      end
    end
  end
end
