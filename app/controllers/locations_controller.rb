class LocationsController < ApplicationController
    before_action :require_login
    before_action :set_location, only: [:show, :edit, :update, :destroy] 

    def index
        @locations = Location.all
    end

    def new
        @location = Location.new
    end

    def create
        @location = Location.new(location_params)
        if @location.save
            redirect_to location_path(@location)
        else
            redirect_to new_location_path(@location), error: "Error: #{@location.errors.full_messages.join(", ")}"
        end
    end

    def show
        @location = Location.find_by_id(params[:id])
        @users = @location.users
    end

    def edit
        @location = Location.find_by_id(params[:id])
        render :edit
    end

    def update
        @location = Location.find_by(id: params[:id])
        if @location.update(location_params)
            redirect_to location_path(@location)
        else
            redirect_to edit_location_path(@location), error: "Error: #{@location.errors.full_messages.join(", ")}"
        end
    end

    def destroy
        Location.find(params[:id]).destroy
        flash[:notice] = "Location deleted."
        redirect_to '/locations/'
    end

    
    private

    def location_params
        params.require(:location).permit(:name, :notes, :task_ids => [])
    end

    def set_location
        @location = Location.find_by(id: params[:id])
    end
end