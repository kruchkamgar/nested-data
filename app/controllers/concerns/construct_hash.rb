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
      Pointer.new(value: d.attributes) end

    groups =
    nested_data
    .group_by do |d|
      d.value["subItemOf_ID"] end
    groups
    .reject do |group|
      group == 0 end
    .each do |group|
      # find parent', and assign group to its :sub_items. *1
      nested_data
      .find do |d|
        d.value["id"] == group[0] end
      .value[:sub_items] =
      group.second
      .sort! do |a,b|
        a.value["name"] <=> b.value["name"] end
    end

    return groups[0]
      .sort! do |a,b|
        a.value["name"] <=> b.value["name"] end
  end


# /////////////  untested alternatives  ///////////// #

  # data structure:
  # [
  #   {elem: []},
  #   elem,
  #   elem
  # ]

  # /////////////// #

  # recursively find parent
  def find_nested_parent(child, array)

    array
    .each do |d|
      if child["subItemOf_ID"] == d["id"]
        then return d end

      if d[:sub_items]
        find_nested_parent(child, d[:sub_items]) end
    end

    # tail call in ruby?
      # - pass along the trailing arrays and resume calling find_nested_parent, in order (?)
  end

  def nested_data_traverse(data)
    data_list = data.clone

    data_list
    .each_with_index do |d, i|
      parent = find_nested_parent(d, data_list)
      if parent[:sub_items]
        parent[:sub_items] << d
      else
        parent = Hash[ item: parent, sub_items: [child] ] end

      data_list.delete_at(i)
    end

  end

# /////////////////////////////////////////////////// #

  # this precludes need to 'find_nested_parent', by working from bottom-of-the-tree, up;
  # places all parents behind children
  def sort_parent_behind_child(data)
    data_list = data.clone

    data_list.each_with_index do |d, parent_index|
      child_index =
      data_list.index do |child|
        child["subItemOf_ID"] == d["id"] end

      # if parent_index then puts data_list[parent_index]["id"] end

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
    .each do |array|
      index =
      data_list
      .index do |row|
        row[0] == array[2] # id == subItemOf_ID
      end

      data_list[index] =
      Hash[ item: data_list[index], sub_items: [array] ]
    end

  end

end


# *1— separate references may point to same object instance (same object_id). Thus preventing balooning performance issues via potentially exponential copying of :sub_items.
