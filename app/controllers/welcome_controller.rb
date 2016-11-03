class WelcomeController < ApplicationController

  def index
    @property = Property.all
  end
end
