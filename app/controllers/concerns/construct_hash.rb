module ConstructHash

  class Pointer
    attr_accessor :value

    def initialize(value: )
      @value = value
    end
  end

  def nested_hash(data)
    nested_data =
    data
    .map do |d|
      d.attributes end

    groups =
    nested_data
    .group_by do |d|
      d["subItemOf_ID"] end
    groups
    .reject do |group|
      group == 0 end
    .each do |group|
      # find parent', and assign group to its :sub_items. *1
      nested_data
      .find do |d|
        d["id"] == group[0] end[:sub_items] =
      group.second
      .sort! do |a,b|
        a["name"] <=> b["name"] end
    end

    return groups[0]
      .sort! do |a,b|
        a["name"] <=> b["name"] end
  end


# /////////////  UNTESTED alternative  ///////////// #

  # data structure:
  # [
  #   {elem: []},
  #   elem,
  #   elem
  # ]

  # /////////////// #



# /////////////////////////////////////////////////// #

  # this approach precludes need to 'find_nested_parent', by working from bottom-of-the-tree, up;
  # places all parents behind children
  def sort_parent_behind_child(data)
    data_list = data.clone

    data_list.each_with_index do |d, parent_index|
      child_index =
      data_list.index do |child|
        child["subItemOf_ID"] == d["id"] end

      if child_index &&
         child_index < d["id"]
      then
        data_list.delete_at(parent_index)
        data_list.insert(child_index+1, d) end
    end

    return data_list
  end

  def nested_hash_simple(data)
    # if sub_item comes before parent item in array

    data_list = data.clone
    data_list
    .each do |item|
      index =
      data_list
      .index do |d|
        item["subItemOf_ID"] == d["id"] # id == subItemOf_ID
      end

      data_list[index] =
      Hash[ item: data_list[index], sub_items: [item] ]
    end

  end

end


# *1— separate references may point to same object instance (same object_id). Thus preventing balooning performance issues via potentially exponential copying of :sub_items.
