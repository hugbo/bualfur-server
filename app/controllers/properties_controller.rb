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

  def search
    @properties = Property.all
    @search = params[:search]
    if @search
      puts "Search parameters:"
      puts @search.inspect
      puts @search["zipcode"]
      @properties = Property.search(params[:search]).order("created_at DESC")
    end
  end


  private
    def property_params
      params.require(:property).permit(:address, :zipcode, :city, :price, :size, :num_bedrooms, :num_bathrooms, :property_type)
    end
end
