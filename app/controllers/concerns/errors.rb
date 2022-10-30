module Errors
  class Unauthorized < StandardError; end

  class Unauthenticated < StandardError
    attr_reader :message

    def initialize(message: 'invalid_user')
      super
      @message = message
    end
  end

  class MissingArgument < StandardError
    attr_reader :message

    def initialize(argument:)
      super
      @message = "#{argument}_argument_missing"
    end
  end
end

