require 'pry'
class CartsController < ApplicationController

  def checkout
    cart = Card.find(params[:id])
    cart.checkout
    binding.pry
    redirect_to cart_path(cart)
  end

end
