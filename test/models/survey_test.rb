require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    
    @survey = @user.surveys.new(name: "東京調査")
  end
  
  test "survey の有効性を検証" do
    assert @survey.valid?
  end
  
  test "survey nameの存在性を検証する" do
    @survey.name = "     "
    assert_not @survey.valid?
  end
  
  test "survey nameの長さを検証する" do
    @survey.name = "a" * 51
    assert_not @survey.valid?
  end

end
