# Min priority queue implementation
# using a binary heap
# ALL items added should be comparable with each other
# 
# Todo: figure out how to ONLY allow a singular type of comparable data
# # # # # # # # # # # # # # # # # # # # # # # #

class BinaryHeap
  # can pass array of values to initialize the heap with
  def initialize array = nil
    # to keep track of our items
    @heap = []
    # map for log(n) removals
    # { value: SortedSet }
    @map = {}

    unless array.nil?
      raise "can only initialize BinaryHeap with array of values, or empty argument" unless array.kind_of?(Array)
     
      array.each { |item| add(item) }
    end
   end
  
  # Removes the first item from the Heap
  def poll
    remove_at(0)
  end

  # returns the value of the item with the lowest priority
  # returns nil if heap is empty
  def peek
    return nil if empty?

    @heap[0]
  end

  # adds item to the binary heap
  # places the item at the end of the heap, then "bubbles it up"
  # O(log n)
  def add value
    raise 'Cannot add nil values to the heap.' if value.nil?
    # push onto the end of the @heap array
    @heap.push(value)
    new_item_index = @heap.size - 1
    # add it to our map
    map_add(value, new_item_index)
    # swim it upward ("bubble up") to where it belongs
    swim(new_item_index)
  end

  # Removes an item at particular index
  # O(log n)
  def remove_at index
    return nil if empty?
    removed_value = @heap[index]
    last_item_index = size - 1
    swap_values_at(index, last_item_index)

    # Remove the actual value off the heap,
    # now that it's at the end/bottom of the heap
    @heap.pop
    remove_from_map(removed_value, last_item_index)

    # Return now, if this item was the last item already
    return removed_value if index == last_item_index

    # redefine our interested item, post-swap
    new_item_at_index = @heap[index]
    # Try to sink the item we moved, which now exists at `index`
    sink(index)
    # Otherwise try to swim it up, if it could not sink,
    # thus the 
    swim(index) if @heap[index] == new_item_at_index

    return removed_value
  end

  # Removes a particular value from the heap
  # runs at O(log n) because of our Hash map
  def remove value
    return false if value.nil?

    index = map_get_index_of(value)
    remove_at(index) unless index.nil?

    return !index.nil?
  end

  # using our hash map, this runs at:
  # O(1)
  def contains? value
    return false if value.nil?

    @map.has_key?(value)
  end

  def size
    @heap.size
  end

  def empty?
    @heap.empty?
  end

  def clear
    @heap.clear
    @map.clear

    return nil
  end

  private

  # perform a top-down, "bubble down" for the item
  # located at `index` in the heap array
  def sink index
    loop do
      # define all other relevant index values
      last_item_index = size - 1
      l_child = 2 * index + 1
      r_child = 2 * index + 2
      # default to L in case of tie
      smaller_child = l_child
      # set smaller_child to right_child if that is a valid index and it is less than the left
      smaller_child = r_child if (r_child < last_item_index && less_than?(r_child, l_child))
      # if we are outside the bounds of our tree
      # or if we cannot sink item at `index` anymore
      break if (l_child >= last_item_index || less_than?(index, smaller_child))
      # otherwise, swap the values, "bubbling" the item down
      swap_values_at(smaller_child, index)
      # set the new index to the positions we've just moved to
      index = smaller_child
    end
  end

  # perform a bottom-up, "bubble up" for the item
  # located at `index` in the heap array
  def swim index
    parent_index = (index - 1) / 2

    # continue to bubble upward while we have not reached the root,
    # and while we are less than the parent element
    while (index > 0 && less_than?(index, parent_index))
      
      # swap the two values
      swap_values_at(index, parent_index)
      index = parent_index
      # set new parent index based on the bubble up
      parent_index = (index - 1) / 2
    end
  end

  # swap two elements by their index
  def swap_values_at i, j
    value_i = @heap[i]
    value_j = @heap[j]

    @heap[i] = value_j
    @heap[j] = value_i

    map_swap(value_i, value_j, i, j)
  end

  # Adds a node value and its index to the @map
  def map_add value, index
    sorted_set = @map[value]

    if sorted_set.nil?
      sorted_set = SortedSet.new.add(index)

      @map[value] = sorted_set
    else
      # a key already, so just add the index into its sorted set
      sorted_set.add(index)
    end
  end

  # swaps the indexes for two values
  def map_swap value_i, value_j, index_i, index_j
    set_i = @map[value_i]
    set_j = @map[value_j]

    set_i.delete?(index_i)
    set_j.delete?(index_j)

    set_i.add(index_j)
    set_j.add(index_i)
  end

  # removes a value from the hash map
  def remove_from_map value, index
    # Recreates `value`s SortedSet without the given index
    @map[value].delete?(index)

    # Remove this value from our map, if the sorted set is now empty
    # i.e. no more elements exists in our heap with that value
    @map.delete(value) if @map[value].empty?
  end

  # checks if value exists in our map
  # if numerous values exist, we choose
  # the highest index (arbitrarily)
  def map_get_index_of value
    sorted_set = @map[value]
    return nil if sorted_set.nil?

    return sorted_set.to_a.last
  end

  # return true if values in @heap[i] <= @heap[j]
  # assumes both are valid indices
  def less_than? i, j
    return (@heap[i] <= @heap[j])
  end

  def levels_in_tree
    return 0 if empty?

    1 + Math.log2(size).floor
  end
end