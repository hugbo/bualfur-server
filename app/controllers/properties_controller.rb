class PropertiesController < ApplicationController

    # functions defined from rails routes

    def index
    end

    def show
        @property = Property.find(params[:id])
    end

    def new
      if !(current_user.present?)
        redirect_to root_path(:unauthorized_creation => true)
      end
    end

    def edit
    end

    def create
        @property = Property.new(property_params)

        @property.save
        redirect_to @property
    end

    def update
    end

    def destroy
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

    private

    def property_params
        params.require(:property).permit(:address, :zipcode, :city, :price, :size, :num_bedrooms, :num_bathrooms, :property_type, :lat, :lon)
    end
end
