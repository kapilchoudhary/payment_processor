class Api::V1::TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ApiAuthenticationHandler

  before_action :authenticate_api_request!
  before_action :set_parent_transaction, only: %i[charge_transaction refund_transaction reversal_transaction]

  def create
    transaction = AuthorizeTransaction.new(transaction_params)
    if transaction.save
      json_response(transaction.as_json, 200)
    else
      json_response(transaction.errors.as_json, 400)
    end
  end

  def charge_transaction
    if @parent_transaction.authorized?
      charge_transaction = @parent_transaction.charge_transactions.new(update_transaction_params.merge(status: 'approved'))
      if charge_transaction.save
        json_response(charge_transaction.as_json, 200)
      else
        json_response(charge_transaction.errors.as_json, 400)
      end
    else
      json_response({ error: 'Authorize transaction required' }, 400)
    end
  end

  def refund_transaction
    if @parent_transaction.charged?
      refund_transaction = @parent_transaction.refund_transactions.new(update_transaction_params.merge(status: 'refunded'))
      if refund_transaction.save
        json_response(refund_transaction.as_json, 200)
      else
        json_response(refund_transaction.errors.as_json, 400)
      end
    else
      json_response({ error: 'Charge transaction required' }, 400)
    end
  end

  def reversal_transaction
    if @parent_transaction.authorized?
      reversal_transaction = @parent_transaction.reversal_transactions.new(reverse_transaction_params)
      if reversal_transaction.save
        json_response(reversal_transaction.as_json, 200)
      else
        json_response(reversal_transaction.errors.as_json, 400)
      end
    else
      json_response({ error: 'Authorize transaction required' }, 400)
    end
  end

  private

  def set_parent_transaction
    @parent_transaction = current_user.transactions.find_by(id: params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :customer_email, :customer_phone).merge(merchant_id: current_user.id)
  end

  def update_transaction_params
    params.require(:transaction).permit(:amount).merge(parent_attributes)
  end

  def reverse_transaction_params
    parent_attributes.merge(status: 'reversed', amount: 0)
  end

  def parent_attributes
    @parent_transaction.attributes.slice('customer_email', 'customer_phone', 'merchant_id')
  end
end