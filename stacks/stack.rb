# Stack implementation
# utilizes a doubly linked list
# # # # # # # # # # # # # # # # # # # # # # # #

require_relative '../linked-lists/doubly_linked_list.rb'

class Stack
  include Enumerable

  # used as default argument for initialize;
  # allows for `nil` to be passed as argument
  NO_ARG = Object.new

  def initialize value = NO_ARG
    @list = LinkedList.new

    push(value) unless value == NO_ARG
  end

  def size
    @list.size
  end

  def empty?
    @list.size == 0
  end

  def push element
    @list.add_last(element)
  end

  def pop
    raise 'Cannot pop element from an empty stack.' if empty?

    @list.remove_last
  end

  # Allows for enumerating over each item in the stack
  def each
    return enum_for(__method__) unless block_given?
    return if empty?
    
    @list.each do |node|
      yield node.data
    end
  end
end