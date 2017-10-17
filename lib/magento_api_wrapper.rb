require 'savon'

require 'magento_api_wrapper/connection'
require 'magento_api_wrapper/savon_client'

require 'magento_api_wrapper/request'
Dir[File.dirname(__FILE__) + "/magento_api_wrapper/requests/*.rb"].each do |file|
  require file
end
Dir[File.dirname(__FILE__) + "/magento_api_wrapper/params/*.rb"].each do |file|
  require file
end

require 'magento_api_wrapper/response'
require 'magento_api_wrapper/responses'
require 'magento_api_wrapper/version'

require 'magento_api_wrapper/api'
Dir[File.dirname(__FILE__) + "/magento_api_wrapper/api/*.rb"].each do |file|
  require file
end

require 'magento_api_wrapper/api_error'


module MagentoApiWrapper
  class Error < StandardError; end
  class UnknownError < StandardError; end
  class MagentoError < Error; end
  class AuthenticationError < Error; end
  class UnknownRequest < Error; end
  class UnavailableError < Error; end
  class BadRequest < Error; end
end
