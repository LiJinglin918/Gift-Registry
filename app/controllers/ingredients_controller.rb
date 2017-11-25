class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit, :update, :show]
  def new
    @ingredient = Ingredient.new
    
  end
  
  def create  
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Gift was successfully created"
      redirect_to ingredient_path(@ingredient)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page],per_page: 5)
  end
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end
  
  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = "Gift name was updated successfully"
      redirect_to @ingredient
    else
      render 'edit'
    end
  end
  
  private
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
  
end
