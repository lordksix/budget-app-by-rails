class GroupsController < ApplicationController
  layout 'home'
  before_action :find_group, only: %i[show destroy edit update]
  before_action :authenticate_user!

  def index
    @groups = current_user.groups.includes(:spendings).order(updated_at: :desc)
    @current_user = current_user
    @groups.each do |group|
      total_spending = group.spendings.reduce(0.0) do |acc, item|
        acc + item.amount
      end
      group.total_spending = total_spending
    end
    @title = 'Categories'
    @home = 'BURGER'
  end

  def show
    total_spending = @group.spendings.reduce(0.0) do |acc, item|
      acc + item.amount
    end
    @group.total_spending = total_spending
    @spendings = @group.spendings.includes(:author).order(updated_at: :desc)
    @current_user = current_user
    @title = 'Transactions'
    @home = 'BACK'
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Category was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def new
    @group = Group.new
    @current_user = current_user
    @title = 'New Category'
    @home = 'BACK'
  end

  def create
    new_group = Group.new(group_params)
    new_group.user = current_user
    respond_to do |format|
      if new_group.save
        format.html { redirect_to groups_path, notice: 'Category was successfully created.' }
        format.json { render :index, status: :created, location: new_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: new_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @current_user = current_user
    @home = 'BACK'
    @title = 'Edit Category'
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to group_url(@group), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_group
    @group = Group.find_by(id: params['id'])
  end

  def group_params
    params.require(:group).permit(:name, :icon,
                                  groups_spendings_attributes: %i[spending_id _destroy])
  end
end
