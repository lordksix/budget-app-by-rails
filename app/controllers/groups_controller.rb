class GroupsController < ApplicationController
  layout 'home'
  before_action :find_group, only: %i[show destroy edit update]
  before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: [:show]
  # authorize_resource only: [:show]

  def index
    @groups = current_user.groups.includes(:spendings).order(:updated_at)
    @current_user = current_user
    @groups.each do |group|
      total_spending = group.spendings.reduce(0.0) do |acc, item|
        acc + item.amount
      end
      group.total_spending = total_spending
    end
    @title = 'Categories'
    @home = true
  end

  def show
    total_spending = @group.spendings.reduce(0.0) do |acc, item|
      acc + item.amount
    end
    @group.total_spending = total_spending
    @spendings = @group.spendings.includes(:author).order(:updated_at)
    @current_user = current_user
    @title = 'Details'
    @home = true
  end

  def destroy
    @groups.destroy
    redirect_to groups_path
  end

  def new
    @group = Group.new
    @current_user = current_user
    @group.spendings.build
    @spendings_map = @current_user.spendings.pluck(:name, :id, :amount)
  end

  def create
    new_group = Group.new(group_params)
    new_group.user = current_user
    if new_group.save
      flash[:sucess] = 'Recipe saved successfully'
      redirect_to groups_path
    else
      flash[:error] = 'Error: Recipe could not be saved'
    end
  end

  def edit
    @current_user = current_user
    @spendings_map = @current_user.spendings.pluck(:name, :id, :amount)
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to recipe_url(@group) }
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
