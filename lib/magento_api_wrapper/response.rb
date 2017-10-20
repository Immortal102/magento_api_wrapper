module MagentoApiWrapper
  class Response

    attr_accessor :document

    #Creates a ruby hash from objects returned by Savon
    def initialize(response)
      @document = response.to_hash
    end

    private
    def array_wrapped(data)
      Array.wrap(data)
    end
  end
end
