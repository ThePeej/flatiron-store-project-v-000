require 'pry'
class CartsController < ApplicationController

  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    cart = Cart.find(params[:id])
    cart.checkout
    User.find(cart.user_id).remove_cart
    redirect_to cart_path(cart)
  end

end
