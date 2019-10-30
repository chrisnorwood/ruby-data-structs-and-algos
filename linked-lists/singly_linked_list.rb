# A singly linked list implementation
#
# # # # # # # # # # # # # # # # # # #

class LinkedList
  # including Enumerable, and defining #each allows me full power of Enumerable in this Class
  include Enumerable

  attr_reader :size

  ##########################################
  # Internal 'private' class to represent data
  class Node
    attr_accessor :data, :next_node

    def initialize data, next_node = nil
      @data = data
      @next_node = next_node
    end

    def to_s
      @data.to_s
    end
  end
  ##########################################

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def empty?
    return (size == 0)
  end

  # Add an element to the tail of the linked list
  # (alias for add_last)
  # O(1)
  def add element
    add_last(element)
  end

  # Add an element to the tail of the linked list
  # O(1)
  def add_last element
    if empty?
      @head = @tail = Node.new(element, nil)
    else
      @tail.next_node = Node.new(element, nil)
      @tail = @tail.next_node
    end
    @size += 1

    return nil
  end

  # Add an element to the tail of the linked list
  # O(1)
  def add_first element
    if empty?
      @head = @tail = Node.new(element, nil)
    else
      @head = Node.new(element, @head)
    end
    @size += 1

    return nil
  end

  def peek_first
    raise 'Cannot peek at element of an empty list.' if empty?

    return @head.data
  end

  def peek_last
    raise 'Cannot peek at element of an empty list.' if empty?

    return @tail.data
  end

  # Remove first node in the linked-list
  # O(1)
  def remove_first
    raise 'Cannot remove element from an empty list.' if empty?

    # Extract the data off of the head node
    # Move the head to the next node
    data = @head.data
    @head = @head.next_node
    @size -= 1

    # removes the same element from @tail, if it was final element/node
    if empty?
      @tail = nil
    end

    return data
  end

  # Remove last node in the linked-list
  # O(n)
  def remove_last
    raise 'Cannot remove element from an empty list.' if empty?

    # Extract the data off of the tail node
    # Move the tail to the previous node
    data = @tail.data
    
    if size < 2
      return remove_first
    else
      each_cons(2) do |node, next_node|
        if next_node.next_node == nil
          @tail = node
          @tail.next_node = nil
          break
        end
      end
    end

    @size -= 1

    return data
  end

  # Remove a node at given index
  # O(2n) -> reduces to -> O(n)
  def remove_at index
    raise ArgumentError.new("There is no value at the given index") if (index < 0 || index >= @size)

    each_with_index do |node, enum_index|
      return remove(node) if index == enum_index
    end
  end
  
  # returns the (first) index of a given value in the list
  # returns -1 if the value does not exist
  # O(n)
  def index_of element
    # Can search for nil values
    if element == nil
      each_with_index do |node, index|
        return index if node.data == nil
      end
      # searching for non-nil values
    else
      each_with_index do |node, index|
        return index if node.data == element
      end
    end

    return -1
  end

  # Returns whether or not an element exists in this linked-list
  def contains? element
    return (index_of(element) != -1)
  end

  # Shows the linked list represented as a string
  # enclosed in square-brackets
  def to_s
    print "[ "

    each do |node|
      print "#{node.data}"
      print ", " unless node.next_node == nil
    end

    print " ]\n"
  end

  # Allows this item to be a ruby Enumerator
  # We can use this in other methods
  def each
    return enum_for(__method__) unless block_given?
    return if @head.nil?

    traverser = @head

    until traverser.nil?
      yield traverser
      traverser = traverser.next_node
    end
  end

  # Make Node as `private` as Ruby can
  private_constant :Node

  private

  # Removes a specific Node instance from the list
  def remove node
    # if the node is at beginning or end of list
    # handle this separately
    return remove_first if node == @head
    return remove_last if node == @tail

    # store the data, so we can return it
    data = node.data

    # iterate through nodes, two at a time
    each_cons(2) do |search_node, next_node|
      # if our second item in a pair is the node we are looking for
      if next_node == node
        # then make the previous node's (i.e the search_node) next node equal to the FOLLOWING
        search_node.next_node = next_node.next_node
        next_node = nil
        break
      end
    end

    @size -= 1

    return data
  end
end