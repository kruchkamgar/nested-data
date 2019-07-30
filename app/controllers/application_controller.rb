class ApplicationController < ActionController::Base

  def index
  end

include ConstructHash
include ConstructHashNestedEdit
  def show_items
    # performance: sort Item first, then construct multi-dimensional array from bottom up?
      # yet on updating the nested structure, must traverse multi-dimensional array, anyway.

    @items = []
    Item
    .find_each() do |item| # limits batch size to default of 1000
      @items << item end

    @nested_hash = nested_hash(@items)

    data_list = nested_data_traverse(@items)
    byebug

  end

end
