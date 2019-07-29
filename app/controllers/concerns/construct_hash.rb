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


end



# *1— separate references may point to same object instance (same object_id). Thus preventing balooning performance issues via potentially exponential copying of :sub_items.
