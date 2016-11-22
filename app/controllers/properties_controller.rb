class PropertiesController < ApplicationController

    # Handler for creating property listings and saving to database
    def create
        @property = Property.new(property_params)
        @property.landlord = current_user

        @property.save
        redirect_to @property
    end

    def destroy
    end

    # Handler for dealing with
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
        redirect_to root_path(:unauthorized_creation => true)
      end
    end

    # Fetches property listings of logged in user
    def my_properties
      @user_id = current_user.id
      @properties = Property.where(:uid => @user_id)
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
        @property = Property.find(params[:id])
    end

    def update
      @property_to_update = Property.find(params[:id])
      puts params[:property][:address]

      if @property_to_update.update_attributes(property_params)
        redirect_to(:action => 'show')
      else
        redirect_to(root_path)
      end
    end

    private
    # Private method for database obfuscation
    def property_params
        params.require(:property).permit(:address, :zipcode, :city, :price, :size, :num_bedrooms, :num_bathrooms, :property_type, :lat, :lon)
    end
end
