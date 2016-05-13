require 'redis-objects'

module WebsocketRails

  class << self

    def channel_manager
      @channel_manager ||= ChannelManager.new
    end

    def [](channel)
      channel_manager[channel]
    end

    def channel_tokens
      channel_manager.channel_tokens
    end

  end

  class ChannelManager

    attr_reader :channels

    def initialize
      @channels = {}.with_indifferent_access
    end

    def channel_tokens
      @channel_tokens ||= begin
        if WebsocketRails.synchronize?
          ::Redis::HashKey.new('websocket_rails.channel_tokens', Synchronization.redis)
        else
          {}
        end
      end
    end

    def [](channel)
      @channels[channel] ||= Channel.new channel
    end

    def unsubscribe(connection)
      @channels.each do |channel_name, channel|
        channel.unsubscribe(connection)
      end
    end

  end
end
