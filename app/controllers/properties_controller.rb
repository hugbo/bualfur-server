class PropertiesController < ApplicationController
    skip_before_action :verify_authenticity_token


    # Handler for creating property listings and saving to database
    def create
        @property = Property.new(property_params)
        @property.landlord = current_user

        @property.save
        redirect_to @property
    end

    def destroy
      @property = Property.find(params[:id])
      @property.destroy
      redirect_to action: "show_profile", controller: "profile", id: current_user.id
    end

    # Handler for dealing with request to edit property
    def edit
      @property_to_edit = Property.find(params[:id])
      if @property_to_edit.landlord != current_user
        redirect_to root_path
      end
    end

    def index
    end

    # Handler for request to create new property in database
    def new
      if !(current_user.present?)
        redirect_to root_path, flash: {error: "You need to be logged in to create listings"}
      end
    end


    def search
        @search = params[:search]
        if @search
            puts 'Search parameters:'
            puts @search.inspect
            puts @search['zipcode']
            @properties = Property.search(params[:search]).order('created_at DESC')
        else
          @properties = Property.all
        end
    end

    def show
      if !(current_user.present?)
        redirect_to root_path, flash: {error: "Þú þarft að vera skráð(ur) inn!"}
      end

      begin
        @property = Property.find(params[:id])
      rescue
        redirect_to root_path, flash: {error: "Property does not exist"}
      end
    end

    def update
      @property_to_update = Property.find(params[:id])
      if @property_to_update.update_attributes(property_params)
        redirect_to(:action => 'show')
      else
        redirect_to(root_path)
      end
    end

    private
    # Private method for database validation
    def property_params
        params.require(:property).permit(:address, :zipcode, :city, :price,
          :size, :num_bedrooms, :num_bathrooms, :property_type, :lat, :lon,
          :image1, :image2, :image3, :image4, :description)
    end
end
