class ApiException < StandardError
  attr_reader :code, :message, :detail

  def initialize(code, exception_type)
    @code = code
    @message = error[:message]
    @detail = error[:errors].map{ |e| "Field #{e[:field]} on #{e[:resource]} is #{e[:code]}" }.join(", ")
    super(detail)
  end
end
