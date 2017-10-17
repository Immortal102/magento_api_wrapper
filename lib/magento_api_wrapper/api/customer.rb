module MagentoApiWrapper
  class Customer < MagentoApiWrapper::Api
    #Mage_Customer

    #TODO:
    #-customer_group.list - Allows you to export customer groups from Magento
    #-customer.list - Retrieve the list of customers
    #-customer.create - Create a new customer
    #-customer.info - Retrieve the customer data
    #-customer.update - Update the customer data
    #-customer.delete - Delete a required customer
    #-customer_address.list - Retrieve the list of customer addresses
    #-customer_address.create - Create a new address for a customer
    #-customer_address.info - Retrieve the specified customer address
    #-customer_address.update - Update the customer address
    #-customer_address.delete - Delete the customer address

    def customer_list(params = {})
      params.merge!(session_params)
      document = MagentoApiWrapper::Requests::CustomerCustomerList.new(params)
      request = MagentoApiWrapper::Request.new(magento_url: params[:magento_url], call_name: :customer_customer_list)
      request.body = document.body
      request.attributes = document.attributes
      customers = MagentoApiWrapper::CustomerCustomerList.new(request.connect!)
      customers.collection
    end
  end
end
