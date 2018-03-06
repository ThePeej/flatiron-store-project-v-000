require 'pry'
class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :users

  def total
    @total = 0
    self.line_items.each do |line_item|
      @total += line_item.total
    end
    @total
  end

  def add_item(item_id)
    item = self.line_items.find_by(:item_id => item_id)
    if !!item
      item.quantity += 1
    else
      item = self.line_items.build(:item_id => item_id)
    end
    item
  end

  def checkout
    self.update(status: 'submitted')
    change_inventory
  end

  def change_inventory
    if self.status = "submitted"
      self.line_items.each do |line_item|
        line_item.item.inventory -= line_item.quantity
        line_item.item.save
      end
    end
  end

end
