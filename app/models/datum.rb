require 'csv'

class Datum < ApplicationRecord
  belongs_to :survey
 
   def self.import(survey)
    CSV.foreach(survey.file.path, {
      encoding: "cp932:utf-8", headers: true, skip_blanks: true }) do |row|
      survey.data.create!(
        site_name: row["調査地点名称"],
        researcher_name: row["調査者名"],
        date: row["日付"],
        latitude: row["緯度"].to_f,
        longitude: row["経度"].to_f,
        value1: row["流れる水の量"].to_f,
        value2: row["岸のようす"].to_f,
        value3: row["魚が川を遡れるか"].to_f,
        value4: row["川原と水辺の植物"].to_f,
        value5: row["鳥の生息、すみ場"].to_f,
        value6: row["魚の生息、すみ場"].to_f,
        value7: row["川底の様子と底生生物"].to_f,
        value8: row["透視度"].to_f,
        value9: row["水のにおい"].to_f,
        value10: row["COD"].to_f,
        value11: row["けしき(感じる)"].to_f,
        value12: row["ごみ(見る)"].to_f,
        value13: row["水との触れ合い"].to_f,
        value14: row["川のかおり(かぐ)"].to_f,
        value15: row["川の音(聞く)"].to_f,
        value16: row["歴史と文化"].to_f,
        value17: row["水辺の近づきやすさ"].to_f,
        value18: row["日常的な利用"].to_f,
        value19: row["産業などの活動"].to_f,
        value20: row["環境の活動"].to_f,
        value21: row["自然なすがた"].to_f,
        value22: row["豊かな生き物"].to_f,
        value23: row["水のきれいさ"].to_f,
        value24: row["快適な水辺"].to_f,
        value25: row["地域とのつながり"].to_f)
        
      end
  end  
  def survey_name
    self.survey.name
  end 
  
end
