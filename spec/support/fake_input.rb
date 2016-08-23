class FakeInput
  attr_reader :responses
  
  def initialize(expected_responses = [])
    @responses = expected_responses
  end

  def gets 
    @responses.shift
  end
end
