module MagentoApiWrapper::Requests
  class SalesOrderList

    attr_accessor :data

    def initialize(data = {})
      @data = data
    end

    def body
      sales_order_list_hash.merge(filters)
    end

    def attributes
      { session_id: { "xsi:type" => "xsd:string" } }
    end

    def filters
      MagentoApiWrapper::FilterParams.new(data).output_data
    end

    def sales_order_list_hash
      { session_id: self.session_id }
    end

    def session_id
      data[:session_id]
    end
  end
end
