require 'fb/configuration'

# An object-oriented Ruby client for Facebook.
# @see http://www.rubydoc.info/gems/fb-core/
module Fb
  # Provides methods to read and write global configuration settings.
  #
  # A typical usage is to set the API keys for a Facebook app.
  #
  # @example Set the API client id/secret for a Facebook app:
  #   Fb.configure do |config|
  #     config.client_id = 'ABCDEFGHIJ1234567890'
  #     config.client_secret = 'ABCDEFGHIJ1234567890'
  #   end
  #
  # Note that Fb.configure has precedence over values through with
  # environment variables (see {Fb::Models::Configuration}).
  #
  module Config
    # Yields the global configuration to the given block.
    #
    # @example
    #   Fb.configure do |config|
    #     config.client_id = 'ABCDEFGHIJ1234567890'
    #   end
    #
    # @yield [Fb::Models::Configuration] The global configuration.
    def configure
      yield configuration if block_given?
    end

    # Returns the global {Fb::Models::Configuration} object.
    #
    # While this method _can_ be used to read and write configuration settings,
    # it is easier to use {Fb::Config#configure} Fb.configure}.
    #
    # @example
    #     Fb.configuration.client_id = 'ABCDEFGHIJ1234567890'
    #
    # @return [Fb::Models::Configuration] The global configuration.
    def configuration
      @configuration ||= Configuration.new
    end
  end

  # @note Config is the only module auto-loaded in the Fb module,
  #       in order to have a syntax as easy as Fb.configure
  extend Config
end