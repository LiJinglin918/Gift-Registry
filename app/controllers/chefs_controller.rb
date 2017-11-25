class ChefsController < ApplicationController
  
  before_action :set_chef, only: [:show, :edit, :destroy,:update]
  before_action :require_same_user, only: [:edit,:update,:destroy]
  before_action :require_admin, only: [:destroy]
  
  
  def new
    @chef=Chef.new
  end
  def index
    @chefs=Chef.paginate(page: params[:page],per_page: 2)
  end
  
  # the name, email, password will be recieved by create action
  def create
    @chef=Chef.new(chef_params)
    if @chef.save
      session[:chef_id]=@chef.id
      flash[:success]="Welcome #{@chef.chefname} to MyGifts App!"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end
  
  def show
    @chef_recipes=@chef.recipes.paginate(page: params[:page],per_page: 2)
  end
  
  def edit
  end
  
  def update
    if @chef.update(chef_params)
      flash[:success]="you account was updated successfully"
      redirect_to @chef
    else
      render 'edit'
    end
  end
  
  def destroy
    if !@chef.admin?
      @chef.destroy
      flash[:danger]="Account and all associated gifts has been deleted"
      redirect_to chefs_path
    end
  end
  
  
  private
  
  def set_chef
    @chef=Chef.find(params[:id])

  end
  def chef_params
    params.require(:chef).permit(:chefname,:email,:password,:password_confirmation)
  end
  
  def require_same_user
    if current_chef != @chef and !current_chef.admin?
      flash[:danger]="you can only edit or delete your own account"
      redirect_to chefs_path
    end
  end
  def require_admin
    if logged_in? && !current_chef.admin?
      flash[:danger]="Only admin can delete the chef"
      redirect_to root_path
    end
  end
  
end