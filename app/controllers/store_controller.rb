class StoreController < ApplicationController
  include CurrentCart

  before_action :visit_counter, only: [:index]
  before_action :set_cart

  def index
    @products = Product.order(:title)
  end

  private

    def visit_counter
      if session[:counter].nil?
        session[:counter] = 1
      else
        session[:counter] += 1
      end
    end
end
