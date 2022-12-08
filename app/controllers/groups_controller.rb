class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "You have create group successfully."
      redirect_to groups_path
    else
      render :new
    end
  end

  def show

  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def edit

  end

  def destroy

  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:image)
  end
end
