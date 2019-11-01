# Union find implementation including
# path compression for greater efficiency
#
# - current implementation is not based on any particular type
#   of nodes/elements, rather it works with nodes of subsequently
# # # # # # # # # # # # # # # # # # # # # # # #

class UnionFind
  attr_reader :size, :num_groups

  def initialize (size)
    raise ArgumentError.new('Input must be single integer.') unless size.kind_of?(Integer)

    # number of nodes/elements in the union find
    @size = size

    # value at parent[node_id] refers to the parent of each item;
    # if parent[node_id] = node_id, then node_id is a root node
    # ** thus, the INDICES of this array represent our actual node #s, the values
    #    represent the parents
    @parent = Array(0...size)

    # keep track of the number of groups/components/node-sets in the union find
    @num_groups = size

    # track the size of each group/component-set/node-set
    # each group is initially size 1 (self-parents)
    @group_size = Array.new(size, 1)
  end

  # Find which group node_id belongs to
  # Runs in amortized constant time 
  def find node_id
    # find the root/top-parent of node_id,
    # hopping parent->parent, and resetting `root` until we're there
    root = node_id
    root = @parent[root] until root == @parent[root] 

    # "path compression"
    # to give us amortized time complexity
    until node_id == root
      next_node = @parent[node_id]
      @parent[node_id] = root
      node_id = next_node
    end

    return root
  end

  # unifies the groups containing id_1 and id_2
  def unify id_1, id_2
    root_1, root_2 = find(id_1), find(id_2)

    # if they are already in the same group, return
    return false if root_1 == root_2

    # merge smaller group into the larger one
    if @group_size[root_1] < @group_size[root_2]
      # add the smaller's size into the greater
      @group_size[root_2] += @group_size[root_1]
      # subtract from the merged's group size
      @group_size[root_1] -= @group_size[root_1]
      # set new parent
      @parent[root_1] = root_2
    else
      # add the smaller's size into the greater
      @group_size[root_1] += @group_size[root_2]
      # subtract from the merged's group size
      @group_size[root_2] -= @group_size[root_2]
      # set new parent
      @parent[root_2] = root_1
    end

    # as the roots were different, we know the number of groups must subtract 1
    @num_groups -= 1

    return true
  end

  # determines if id_1 and id_2 are connected
  def connected? id_1, id_2
    find(id_1) == find(id_2)
  end

  # return the size of the group that node_id belongs to
  # i.e. its highest PARENT group
  def group_size node_id
    @group_size[find(node_id)]
  end
end