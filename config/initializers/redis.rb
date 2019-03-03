# frozen_string_literal: true

REDIS ||= Redis.new(url: ENV['REDIS_URL'])
