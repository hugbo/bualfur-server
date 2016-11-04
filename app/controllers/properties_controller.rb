class PropertiesController < ApplicationController

  def index
    @properties = Property.all
    if params[:search]
      @properties = Property.search(params[:search]).order("created_at DESC")
    else
      @properties = Property.all.order("created_at DESC")
    end
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

  def getjson
    @properties = Property.all
    if params[:search]
      puts "Search parameters found"
    end
  end


  private
    def property_params
      params.require(:property).permit(:address, :zipcode, :city, :price, :size, :numBedrooms, :numBathrooms, :propertyType)
    end
end
