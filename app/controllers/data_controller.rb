class DataController < ApplicationController

  def index
    @data = Datum.all
  end
     
    def show
        @datum = Datum.find(params[:id])
    end
    
    def new
        @datum = Datum.new
    end
    
  def create
    @datum = Datum.new(datum_params)

    respond_to do |format|
      if @datum.save
        format.html { redirect_to @datum, notice: 'データ登録が完了しました。' }
        format.json { render :show, status: :created, location: @datum }
      else
        format.html { render :new }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
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

