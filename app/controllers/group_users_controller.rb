class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to groups_path
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to groups_path
  end
end
