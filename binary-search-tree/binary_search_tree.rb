# A binary search tree implementation
#
# # # # # # # # # # # # # # # # # # #

class BinarySearchTree
  ##############
  # Internal 'private' class
  class Node
    attr_reader :value
    attr_accessor :left, :right

    def initialize value=nil
      @value = value
      @left = nil
      @right = nil
    end

    # Add new value as child node to self, left or ride
    # allows for duplicates, to L side of tree
    def insert new_value
      if new_value <= @value
        @left.nil? ? @left = Node.new(new_value) : @left.insert(new_value)
      elsif new_value > @value
        @right.nil? ? @right = Node.new(new_value) : @right.insert(new_value)
      end
    end
  end
  ##############

  def initialize
    @root = nil
  end

  def insert value
    if @root.nil?
      @root = Node.new(value)
    else
      @root.insert(value)
    end
  end

  # Applies a "level-order traversal" to perform a breadth-first search
  # of the BST, returning the target_value, if found
  def breadth_first_search target_value, root=@root
    queue = [root]

    until queue.empty?
      current = queue.shift

      # Return value if found
      return current if current.value == target_value

      # Add children to the queue, if they exist
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end

    # returns nil if value not found
    nil
  end

  ###
  # These functions are only reassigning the pointers, but not actually reassigning the objects themselves
  # It will require some more troubleshooting later to proprerly delete the objects
  ###
  # def remove value
  #   node = breadth_first_search(value)
  #   return false if node.nil?

  #   remove_node(node)
  # end

  # def remove_node node
  #   if node.left.nil? && node.right.nil?
  #     node = nil
  #   elsif !node.left.nil? && node.right.nil?
  #     node = node.left
  #   elsif node.left.nil? && !node.right.nil?
  #     node = node.right
  #   else
  #     node = smallest_r_child_of(node)
  #   end

  #   return true
  # end

  # Perform preorder traversal of BST
  def preorder_trav(node=@root, &block)
    return if node.nil?

    yield node
    preorder_trav(node.left, &block)
    preorder_trav(node.right, &block)
  end

  # Perform inorder traversal of BST
  def inorder_trav(node=@root, &block)
    return if node.nil?

    inorder_trav(node.left, &block)
    yield node
    inorder_trav(node.right, &block)
  end

  # Perform postorder traversal of BST
  def postorder_trav(node=@root, &block)
    return if node.nil?

    postorder_trav(node.left, &block)
    postorder_trav(node.right, &block)
    yield node
  end

  # Make Node as `private` as Ruby can
  private_constant :Node

  private
  def smallest_r_child_of node
    smallest_child = nil
    r_child = node.right

    until r_child.nil?
      smallest_child = r_child
      
      r_child = r_child.right
    end
    
    return smallest_child
  end
end

# Some Operations

# b = BinarySearchTree.new
# values = [1, 0, 100, 55, 5, 40, 33, 25, 3, 5]

# puts "Insert the following values into the BST: "
# puts values.to_s

# values.each { |value| b.insert value }

# puts "Then...."

# puts "Pre-order traversal results:"
# puts b.preorder_trav { |node| puts node.value }

# puts "Post-order traversal results:"
# puts b.postorder_trav { |node| puts node.value }

# puts "In-order traversal results:"
# puts b.inorder_trav { |node| puts node.value }

# puts "BFS (level-order traversal) for 25 returns:"
# puts (b.breadth_first_search 25).to_s