# Singly-Linked List
# - A big improvement would be: 
#    incorporating an private #traverse method, to be utilized by the others
# - Could also allow for empty list, if desired

class Node
  attr_accessor :value, :next_node

  def initialize value = nil, next_node = nil
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize head_value
    @head = Node.new(head_value)
    @tail = @head

    return self
  end

  def append value
    # append new Node to end of the chain
    @tail.next_node = Node.new(value)
    
    @tail = @tail.next_node
  end

  def prepend value
    # put new Node into front of chain
    @head = Node.new(value, @head)
  end

  def size
    count = 1
    # begin tracing with the head node
    current = @head

    while current.next_node
      current = current.next_node
      count += 1
    end

    return count
  end

  def at index
    return 'No value exists at that index' if index > size - 1

    node = @head
    trace = 0

    until trace == index
      node = node.next_node
      trace += 1
    end

    return node.value
  end

  def pop
    return "Cannot pop last item" if size == 1

    current = @head

    until current.next_node == @tail
      current = current.next_node
    end
    
    @tail = current
    @tail.next_node = nil

    return true
  end

  def contains? value
    current = @head
    # traverse the nodes
    loop do
      # return if we found value on the head
      return true if current.value == value
      # otherwise step to next node
      current = current.next_node
      # exit loop if we reached the end of the list
      break unless current
    end

    # no match found
    return false
  end

  def find value
    current = @head
    index = 0
    # traverse the nodes
    loop do
      # return if we found value on the head
      return index if current.value == value
      # otherwise step to next node
      current = current.next_node
      index += 1
      # exit loop if we reached the end of the list
      break unless current
    end

    # no match found
    return nil
  end

  def to_s
    # begin tracing with the head node
    current = @head

    loop do  
      print "( #{current.value} )  -> "
      
      # set tracer to the next node
      current = current.next_node

      unless current
        puts '(nil)'
        break
      end
    end
  end

  private
  
  attr_writer :head
end