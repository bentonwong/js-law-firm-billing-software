class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
  end

  def show
    @expense = Expense.find_by(id: params[:id])
  end

  def destroy
  end
end
