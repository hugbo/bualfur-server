class PropertiesController < ApplicationController

    # functions defined from rails routes

    def create
        @property = Property.new(property_params)
        @property.landlord = current_user

        @property.save
        redirect_to @property
    end

    def destroy
    end

    def edit
    end

    def index
    end

    def new
      if !(current_user.present?)
        redirect_to root_path(:unauthorized_creation => true)
      end
    end

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
    end

    private

    def property_params
        params.require(:property).permit(:address, :zipcode, :city, :price, :size, :num_bedrooms, :num_bathrooms, :property_type, :lat, :lon)
    end
end
