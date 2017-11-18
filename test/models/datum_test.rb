require 'test_helper'

class DatumTest < ActiveSupport::TestCase
  
  def setup
    
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
    
    @survey = @user.surveys.new(name: "東京調査")
    
    @datum = @survey.data.new(      
      site_name:"青森上流調査",
      researcher_name:"工藤誠也",
      date:"2014/03/03 15:22",
      latitude:"0",
      longitude:"0",
      value1:"1",
      value2:"2",
      value3:"3",
      value4:"1",
      value5:"2",
      value6:"3",
      value7:"1",
      value8:"2",
      value9:"3",
      value10:"1",
      value11:"2",
      value12:"3",
      value13:"1",
      value14:"2",
      value15:"3",
      value16:"1",
      value17:"2",
      value18:"3",
      value19:"1",
      value20:"2",
      value21:"3",
      value22:"1",
      value23:"2",
      value24:"3",
      value25:"1")
      
      
  end
  
  
  test "datum の有効性を検証" do
    assert @datum.valid?
  end
  
  test "datum site_nameの存在性を検証する" do
    @datum.site_name = "     "
    assert_not @datum.valid?
  end
  
  test "datum site_nameの長さを検証する" do
    @datum.site_name = "a" * 51
    assert_not @datum.valid?
  end

  test "researcher_nameの存在性を検証する" do
    @datum.researcher_name = "   "
    assert_not @datum.valid?
  end

  test "researcher_nameの長さを検証する" do
    @datum.researcher_name = "a" * 51
    assert_not @datum.valid?
  end

  test "latitude(緯度)の存在性を検証する" do
    @datum.latitude = "   "
    assert_not @datum.valid?
  end
  
  test "latitude(緯度)の緯度は-90~90の間である" do
    @datum.latitude = "91"
    assert_not @datum.valid?
  end
  
  test "longitude(経度)の存在性を検証する" do
    @datum.longitude = "   "
    assert_not @datum.valid?
  end

  test "longitude(経度)の経度は-180~180の間である" do
    @datum.longitude = "181"
    assert_not @datum.valid?
  end

  test "dateは日時である" do
    @datum.date = "2014/03/03 15:123456789"
    assert_not @datum.valid?
  end
  
  test "調査項目は0~3である" do
    @datum.value1 = "10000"
    assert_not @datum.valid?
  end

  test "調査項目はnilでもOK" do
    @datum.value1 = ""
    assert @datum.valid?
  end






  

  
end
