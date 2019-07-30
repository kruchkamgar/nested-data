module ConstructHashNestedEdit

  # recursively find parent
  def find_nested_parent(child, array)

    array
    .each_with_index do |d, i|
      unless d then next end # nils
      if child["subItemOf_ID"] == d["id"]
        then return d
      end

      if d[:sub_items]
        parent = find_nested_parent(child, d[:sub_items])
        return parent if parent
      end
    end

    return nil
    # tail call in ruby?
      # - pass along the trailing arrays and resume calling find_nested_parent, in order (?)
  end


  def nested_data_traverse(data)
    data_list =
    data
    .map do |d|
      d.attributes end

    #byebug
    data_list
    .each_with_index do |d, i|
      parent = find_nested_parent(d, data_list)
      if parent == nil then next end

      # parent = get_nested_element(parent_indices, data_list)

      #byebug
      if parent[:sub_items]
        parent[:sub_items] << d
      else
        parent.merge!(sub_items: [d])
        #byebug
      end

      data_list[i] = nil
    end

    data_list
  end

end
