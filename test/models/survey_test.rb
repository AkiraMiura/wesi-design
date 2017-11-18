require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  
  def setup
    @survey = Survey.new(user_id: 1 , name: "東京調査")
  end
  
  test "survey valid" do

  end

end
