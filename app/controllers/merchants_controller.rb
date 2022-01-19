class MerchantsController < ApplicationController
  before_action :get_merchant, except: [:index]

  def index
  	redirect_to merchant_path(current_user) and return if current_user.is_a?(Merchant)
    @merchants = current_user.merchants
  end

  def show; end

  def edit; end

  def update
    if @merchant.update(merchant_params)
      redirect_to merchant_path(@merchant)
    else
      render :edit
    end
  end

  def destroy
    if @merchant.destroy
      flash[:notice] = 'Merchant deleted successfully'
    else
      flash[:error] = @merchant.errors.full_messages.join(',')
    end
    redirect_to merchants_path
  end

  def transaction_history
    @transactions = @merchant.transactions
  end  

  private

  def merchant_params
    params.require(:merchant).permit(:name, :email, :description, :status)
  end

  def get_merchant
  	if current_user.is_a?(Admin)
  	  @merchant = current_user.merchants.find_by(id: params[:id])
  	else
  	  @merchant = Merchant.find_by(id: params[:id])	
  	end
    
  end
end