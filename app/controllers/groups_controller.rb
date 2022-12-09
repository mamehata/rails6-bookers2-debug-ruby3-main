class GroupsController < ApplicationController
  before_action :owner_user, only:[:edit]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
      flash[:notice] = "You have create group successfully."
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "You have update group successfully."
      redirect_to groups_path
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to users_path
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:image)
  end

  def owner_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
