class SpendingsController < ApplicationController
  layout 'home'
  before_action :authenticate_user!
  before_action :set_spending, only: %i[show destroy]
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
    @current_user = current_user
    @title = 'New Transaction'
    @home = 'BACK'
    @spending = Spending.new
  end

  def create
    @spending = Spending.new(spending_params)
    @spending.author = current_user
    @title = 'New Transaction'
    @home = 'BACK'
    respond_to do |format|
      if @spending.save
        format.html do
          redirect_to group_path(@spending.groups.first), notice: 'Transaction was successfully created.'
        end
        format.json { render :show, status: :created, location: @spending }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @spending.destroy

    respond_to do |format|
      format.html { redirect_to spendings_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_spending
    @spending = Spending.find(params[:id])
  end

  def set_group
    @groups = current_user.groups.order(:created_at)
  end

  def spending_params
    params.require(:spending).permit(:name, :amount, { group_ids: [] })
  end
end
