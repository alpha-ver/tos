module Tos
  class Error < StandardError

    def initialize(message, data=nil)
      super(message)
      @data = data
    end
    attr_reader :data




  end
end
