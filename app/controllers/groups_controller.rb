class GroupsController < ApplicationController
layout 'sidebar_backoffice'

  # GET /groups/1
  def show
    @group = Group.find(params[:id])
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # PUT /groups/1
  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
      redirect_to @group, notice: 'Group was successfully updated.' 
    else
      render action: "edit"
    end
  end
end
