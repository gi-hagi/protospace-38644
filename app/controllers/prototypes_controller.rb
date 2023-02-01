class PrototypesController < ApplicationController
  before_action :prototype_action, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :log_edit, only: [:edit, :update, :destroy]

  def index
    @prototype = Prototype.all
  end
  
  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)

    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_action
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def log_edit
    redirect_to root_path unless current_user == @prototype.user 
  end
end