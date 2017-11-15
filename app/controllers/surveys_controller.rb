class SurveysController < ApplicationController
  
  def index
    @surveys = Survey.all
  end
    
    def show
        @survey = Survey.find(params[:id])
    end
    
    def new
        @survey = Survey.new
    end
    
  def create
    @survey = current_user.surveys.build(survey_params)
      if @survey.save
        Datum.import(@survey)
        flash[:success] = "データを登録しました。"
        redirect_to root_path
      else
        render 'new'
      end
  end
  
    private

    def survey_params
      params.require(:survey).permit(:name, :file)
    end
  
  
  
  
  
    
end
