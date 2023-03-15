class BandsController < ApplicationController
    before_action :set_band, only: [:show,:edit,:update,:destroy]
    def set_band
        @band ||= Band.find_by(id: params["id"])
    end
    def new 
        @band = Band.new
        render :new 
    end

    def index 
        @band = Band.all 
        render :index
    end

    def edit 
        render :edit 
    end

    def show 
        render :show 
    end

    def create 
        @band = Band.new(band_params)

        if @band.save! 
            redirect_to band_url(@band.id)
        else
            redirect_to new_band_url
        end
    end

    def update 
        @band.name = params[:band][:name]
        if @band.save!
            redirect_to band_url(@band.id)
        else
            redirect_to edit_band_url(@band.id)
        end
    end

    def destroy 
        @band.destroy
        redirect_to bands_url
    end 



    def band_params
        params.require(:band).permit(:name)
    end


end
