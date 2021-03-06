require "pry"

class TreeNode
  attr_reader :key, :value
  attr_accessor :left, :right

   def initialize(key, val)
    @key = key
    @value = val
    @left = nil
    @right = nil
   end
end

class Tree
  attr_reader :root
  def initialize
    @root = nil
  end

  # Time Complexity: 
  # Space Complexity: 
  def add(key, value)
    
    # iterative loop way
      if @root.nil? 
        @root = TreeNode.new(key, value)
      else
        current = @root
        while true 
          if key < current.key

            if !current.left.nil?
              current = current.left
            else
              current.left = TreeNode.new(key, value)
              return 
            end
          else
            if !current.right.nil?
              current = current.right
            else
              current.right = TreeNode.new(key, value)
              return 
            end
          end
        end 
      end 
    # recursive way
    # @root = add_helper(@root, key, value)
  end

  def add_helper(current_node, key, value)
    return TreeNode.new(key, value) if current_node.nil?

    if key < current_node.key
      current_node.left = add_helper(current_node.left, key, value)
    else
      current_node.right = add_helper(current_node.right, key, value)
    end
  end 


  # Time Complexity: 
  # Space Complexity: 
  def find(key)
    current_node = @root 
    return find_helper(current_node, key)
  end

  def find_helper(current_node, key)
    if current_node.nil?
      return nil
    end

    returned_value = find_helper(current_node.left, key)
    
    if returned_value != nil
      return returned_value
    end 
    
    if current_node.key == key
      return current_node.value
    end 

    return find_helper(current_node.right, key)
    
  end 

  # Time Complexity: O(n) because I went through each node once 
  # Space Complexity: O(n) because a stack was created
  def inorder
    return inorder_helper(@root, [])
  end

  def inorder_helper(current_node, list)
    return list if current_node.nil?

    inorder_helper(current_node.left, list)
    list << { key: current_node.key, value: current_node.value }
    inorder_helper(current_node.right, list)
    return list
  end 

  # Time Complexity: 
  # Space Complexity: 
  def preorder
    return preorder_helper(@root, [])
  end

  def preorder_helper(current_node, list)

    return list if current_node.nil?

    list << {key: current_node.key, value: current_node.value}

    preorder_helper(current_node.left, list)
    preorder_helper(current_node.right, list)
    return list 
  end 

  # Time Complexity: 
  # Space Complexity: 
  def postorder
    return postorder_helper(@root, [])
  end

  def postorder_helper(current_node, list)
    return list if current_node.nil?

    postorder_helper(current_node.left, list)
    postorder_helper(current_node.right, list)
    list << {key: current_node.key, value: current_node.value}
    return list
    # if current_node.left == nil
    #   list << {key: current_node, value: current_node.value}
    # end 
  end 

  # Time Complexity: 
  # Space Complexity: 
  def height
    current_node = @root

    return height_helper(current_node)
  end

  def height_helper(current_node)

    return 0 if current_node.nil?

    left_height = height_helper(current_node.left)

    right_height = height_helper(current_node.right)

    height_array = [left_height, right_height]

    return height_array.max + 1
  end

  # Optional Method
  # Time Complexity: 
  # Space Complexity: 
  def bfs
    q = []
    list = []

    return [] if @root.nil?

    current_node = @root
    
    q.push(current_node)
    # put current node into queue
    while q.length != 0
      # put current node into list and delete from queue
      # add current node's children into the queue
      list.push({key: q[0].key, value: q[0].value})
      q.shift
      
      if current_node.left != nil 
        q.push(current_node.left) 
      end 

      if current_node.right != nil 
        q.push(current_node.right)
      end
      current_node = q[0]  
    end 

    return list
  end

  # Useful for printing
  def to_s
    return "#{self.inorder}"
  end
end
