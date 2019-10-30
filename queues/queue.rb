# Queue implementation
# utilizing a doubly linked list
# # # # # # # # # # # # # # # # # # # # # # # #

require_relative '../linked-lists/doubly_linked_list.rb'

class Queue
  include Enumerable

  NO_ARG = Object.new

  def initialize value = NO_ARG
    @list = LinkedList.new

    offer(value) unless value == NO_ARG
  end

  def size
    @list.size
  end

  def empty?
    @list.size == 0
  end

  # Enqueue an element onto the back of the queue
  # O(1)
  def offer element
    @list.add_last(element)
  end

  # Dequeue an element from the front of the queue
  # O(1)
  def poll
    raise 'Cannot dequeue element from an empty queue.' if empty?

    @list.remove_first
  end

  # Peek the element on the front of the queue
  def peek
    raise 'Cannot peek on an empty queue.' if empty?

    @list.peek_first
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