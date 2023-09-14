class SpendingsController < ApplicationController
  layout 'home'
  before_action :authenticate_user!
  before_action :set_spending, only: %i[show edit update destroy]
  before_action :set_group, only: %i[new create]

  def index
    @spendings = current_user.spendings.order(created_at: :desc)
    @total_spending = @spendings.reduce(0.0) do |acc, item|
      acc + item.amount
    end
    @current_user = current_user
    @title = 'All Transactions'
    @home = 'BURGER'
  end

  def show
    @current_user = current_user
    @title = 'Transaction'
    @home = 'BACK'
  end

  def new
    @spending = Spending.new
  end

  def edit
    @title = 'Edit Transaction'
    @home = 'BACK'
  end

  def create
    @spending = Spending.new(spending_params)
    @spending.author = current_user
    @title = 'New Transaction'
    @home = 'BACK'
    respond_to do |format|
      if @spending.save
        format.html do
          redirect_to group_path(@spending.groups.first), notice: 'spending was successfully created.'
        end
        format.json { render :show, status: :created, location: @spending }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @spending.update(spending_params)
        format.html { redirect_to spending_url(@spending), notice: 'spending was successfully updated.' }
        format.json { render :show, status: :ok, location: @spending }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @spending.destroy

    respond_to do |format|
      format.html { redirect_to spendings_url, notice: 'spending was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_spending
    @spending = Spending.find(params[:id])
  end

  def set_group
    @groups = Group.order(:created_at)
  end

  # Only allow a list of trusted parameters through.
  def spending_params
    params.require(:spending).permit(:name, :amount, { group_ids: [] })
  end
end
