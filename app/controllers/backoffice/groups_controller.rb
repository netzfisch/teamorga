class Backoffice::GroupsController < ApplicationController
layout 'sidebar_backoffice'

  # GET /backoffice/groups
  def index
    @groups = Group.all
  end

  # GET /backoffice/groups/1
  def show
    @group = Group.find(params[:id])
  end

  # GET /backoffice/groups/new
  def new
    @group = Group.new
  end

  # GET /backoffice/groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /backoffice/groups
  def create
    @group = Group.new(params[:group])

    if @group.save
      redirect_to [:backoffice, @group], notice: 'Group was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /backoffice/groups/1
  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(params[:group])
      redirect_to [:backoffice, @group], notice: 'Group was successfully updated.' 
    else
      render action: "edit"
    end
  end

  # DELETE /backoffice/groups/1
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to backoffice_groups_url 
  end
end
