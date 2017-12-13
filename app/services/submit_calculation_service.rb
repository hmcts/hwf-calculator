require 'rest-client'
class SubmitCalculationService
  attr_reader :response

  def initialize(url, token)
    @url = url
    @token = token
    @response = nil
  end

  def call(data)
    @cached_response = nil
    result = RestClient.post "#{@url}/calculation", { calculation: { inputs: data } }.to_json, accept: 'application/json', content_type: 'application/json'
    if (200..201).cover?(result.code)
      @response = JSON.parse(result.body)
    else
      raise "Something went wrong with the API call"
    end
  end

  def response
    return @cached_response unless @cached_response.nil?
    raise 'Calculation not called' if @response.nil?
    calculation = @response['calculation']
    @cached_response = Calculation.new inputs: calculation['inputs'],
                                       should_get_help: calculation.dig('result', 'should_get_help'),
                                       should_not_get_help: calculation.dig('result', 'should_not_get_help'),
                                       messages: calculation.dig('result', 'messages'),
                                       fields_required: calculation['fields_required'],
                                       required_fields_affecting_likelyhood: calculation['required_fields_affecting_likelyhood'],
                                       fields: calculation['fields']
  end
end
