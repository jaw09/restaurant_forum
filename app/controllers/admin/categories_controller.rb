class Admin::CategoriesController < ApplicationController
  # 驗證請求進入後台的是否為已登入的 User
  before_action :authenticate_user!
  # 驗證該 User 身份是否為網站管理員
  before_action :authenticate_admin

  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "new category was successfully created"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "new category was successfully updated"
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end

  def destroy
    @category.destroy
    flash[:alert] = "category was successfully deleted"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

   def set_category
     @category = Category.find(params[:id])
   end
end
