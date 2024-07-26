class StocksController < ApplicationController
    before_action :authenticate_user!

#   def index
#     @stocks = current_user.stocks
#   end
  def index
    @stocks = current_user.stocks.map do |stock|
      data = stock.fetch_stock_data
      { stock: stock, data: data }
    end
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = current_user.stocks.build(stock_params)
    if @stock.save
      redirect_to stocks_path, notice: 'Stock was successfully added.'
    else
      render :new
    end
  end

  def destroy
    @stock = current_user.stocks.find(params[:id])
    @stock.destroy
    redirect_to stocks_path, notice: 'Stock was successfully deleted.'
  end

  private

  def stock_params
    params.require(:stock).permit(:symbol)
  end
end
