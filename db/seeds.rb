user = User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

survey = Survey.create!(user_id: user.id ,name: "青森調査")
Survey.create!(user_id: user.id ,name: "西滝調査")


Datum.create!(
      survey_id: survey.id ,
      name: "上流",
      site_name:"調査地点名称",
      reseacher_name:"調査者名",
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
      value25:"1"
    )