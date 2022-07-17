class ProductsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "products_channel"
    stream_from "product_#{params[:id]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
