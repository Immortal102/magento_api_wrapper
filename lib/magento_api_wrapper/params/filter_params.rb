module MagentoApiWrapper
  class FilterParams
    attr_accessor :input_data, :output_data

    def initialize(data)
      @input_data = data
      @output_data = {}
      generate
    end

    private

    def generate
      filters = filters_array
      return if filters.empty?
      @output_data = {
        filters: filters_array,
        attributes!: {
          filters: { "xsi:type" => "ns1:filters" }
        }
      }
    end

    def filters_array
      custom_filters = {}
      add_simple_filters(custom_filters)
      add_complex_filters(custom_filters)
      custom_filters
    end

    def add_simple_filters(custom_filters)
      custom_filters[:attributes!] = {
        "filter" => {
          "SOAP-ENC:arrayType" => "ns1:associativeEntity[2]",
          "xsi:type" => "ns1:associativeArray"
        }
      }

      custom_filters["filter"] = {
        item: [],
        attributes!: { item: { "xsi:type" => "ns1:associativeEntity" }}
      }

      simple_filters.each do |sfilter|
        custom_filters["filter"][:item].push(
          {
            key: sfilter[:key],
            value: sfilter[:value],
            :attributes! => {
              key: { "xsi:type" => "xsd:string" },
              value: { "xsi:type" => "xsd:string" }
            }
          }
        )
      end
      custom_filters
    end

    def add_complex_filters(custom_filters)
      custom_filters[:attributes!] = {
        "complex_filter" => {
          "SOAP-ENC:arrayType" => "ns1:complexFilter[2]",
          "xsi:type" => "ns1:complexFilterArray"
        }
      }
      custom_filters["complex_filter"] = {
        item: [],
        attributes!: { item: { "xsi:type" => "ns1:complexFilter" } }
      }

      complex_filters.each do |cfilter|
        custom_filters["complex_filter"][:item].push(
          {
            key: cfilter[:key],
            value: {
              key: cfilter[:operator],
              value: cfilter[:value]
            },
            :attributes! => {
              key: { "xsi:type" => "xsd:string" },
              value: { "xsi:type" => "xsd:associativeEntity" }
            }
          }
        )
      end
      custom_filters
    end

    def formatted_timestamp(timestamp)
      begin
        Time.parse(timestamp).strftime("%Y-%m-%d %H:%M:%S")
      rescue MagentoApiWrapper::BadRequest => e
        raise "Did you pass date in format YYYY-MM-DD? Error: #{e}"
      end
    end

    def simple_filters
      input_data[:simple_filters] || []
    end

    def complex_filters
      input_data[:complex_filters] || []
    end
  end
end
