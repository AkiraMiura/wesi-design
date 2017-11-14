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
    @survey = Survey.new(survey_params)
    if @survey.save
      flash[:success] = "調査の登録に成功しました！"
    else
      flash[:success] = "調査の登録に失敗しました！"
    end
  end
  
    private

    def survey_params
      params.require(:survey).permit(:name)
    end
  
  
  
  
  
    
end
