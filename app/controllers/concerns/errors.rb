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

  class ApplicationError < StandardError
    attr_reader :message, :status
    
    def initialize(status: :unprocessable_entity, message: 'something_went_wrong')
      super
      @message = message
      @status = status
    end
  end
end

