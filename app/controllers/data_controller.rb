class DataController < ApplicationController

  def index
    @datums = Datum.all
  end
     
    def show
        @datum = Datum.find(params[:id])
    end
    
    def new
        @datum = Datum.new
    end
    
  def create
    @datum = Datum.new(survey_params)
    if @datum.save
      flash[:success] = "データの登録に成功しました！"
    else
      flash[:success] = "データの登録に失敗しました！"
    end
  end
  
    private

    def datum_params
      params.require(:datum).permit(
          :name,
          :site_name,
          :reseacher_name,
          :date,
          :latitude,
          :longitude,
          :value1,
          :value2,
          :value3,
          :value4,
          :value5,
          :value6,
          :value7,
          :value8,
          :value9,
          :value10,
          :value11,
          :value12,
          :value13,
          :value14,
          :value15,
          :value16,
          :value17,
          :value18,
          :value19,
          :value20,
          :value21,
          :value22,
          :value23,
          :value24,
          :value25
          )
    end
    
end

