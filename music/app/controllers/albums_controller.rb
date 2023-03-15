class AlbumsController < ApplicationController
    before_action set_album, only: [:show,:edit,:update,:destroy]
    def set_album 
        @album ||= Album.find_by(id: params["id"])
    end

    def new 
        @album = Album.new
        render :new
    end

    def edit 
        render :edit 
    end

    def show 
        render :show 
    end

    def index 
        @albums = Album.all
        render :index
    end

    def destroy 
        if @album.destroy 
            redirect_to albums_url
        else 
            redirect_to album_url(@album.id)
    end

    def create 
        # Need: title, yr, band 
        @album = Album.new(album_params)

        if @album.save!
            redirect_to album_url(@album.id)
        else    
            redirect_to new_album_url 
        end
    end

    def update 
        old_album = @album
        @album = Album.new(album_params)
        if @album.save!
            redirect_to album_url(@album.id)
        else
            redirect_to edit_album_url 
        end
    end

    

    def album_params 
        params.require(:album).permit(:title,:yr,:band)
    end

end
