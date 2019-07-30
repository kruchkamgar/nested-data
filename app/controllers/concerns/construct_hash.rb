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


  # [
  #   {elem: []},
  #   elem,
  #   elem
  # ]

  def sort_parent_ahead_of_child(data)

    data_list = data.clone

    data.each_with_index do |d, index|
      parent_index =
      data.index do |item|
        item["id"] == d["subItemOf_ID"] end

      # if parent_index then puts data[parent_index]["id"] end

      if parent_index &&
         parent_index > d["subItemOf_ID"]
      then
        data_list.delete_at(index)
        data_list.insert(parent_index+1, d) end
    end

    return data_list
  end


  # multi-dimensional
  def nested_hash_simple(data)
    # if sub_item comes before parent item in array

    data_list = data.clone
    nested_hash = []
    data_list
    .each do |array|
      nested_hash[]

      index =
      data_list
      .index do |row|
        row[0] == array[2] # id == subItemOf_ID
      end

      data_list[index] =
      Hash[ item: data_list[index], sub_items: [array[2]] ]


    end

  end



end

# index = nil
#
# data_list
# .find.with_index do |row, i|
#   index = i
#   row[0] == array[2] # id == subItemOf_ID
# end


# *1— separate references may point to same object instance (same object_id). Thus preventing balooning performance issues via potentially exponential copying of :sub_items.
