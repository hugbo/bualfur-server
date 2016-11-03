class PropertiesController < ApplicationController

  def index

  end

  def show
    @property = Property.find(params[:id])
  end

  def new
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


  private
    def property_params
      params.require(:property).permit(:address, :zipcode, :city, :price, :size, :numBedrooms, :numBathrooms, :propertyType)
    end
end
