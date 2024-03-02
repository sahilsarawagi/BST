class Node
  attr_accessor :data,:left,:right
  def initialize(value)
    @left =nil
    @right =nil
    @data = value
  end
end


class Tree
  attr_accessor :root

  def initialize(num)
    @root = build_tree(num.sort.uniq)
  end

  def build_tree(arr)
    start = 0
    last = arr.length-1
    mid= start+last/2
    if start>last
      return nil
    end
    root = Node.new(arr[mid])
    root.left= build_tree(arr[start...mid])
    root.right= build_tree(arr[mid+1..last])

    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(num,node=@root)
    if node==nil
      return node= Node.new(num)
    end

    if node.data>num
      node.left = insert(num,node.left)
    else node.data<num
      node.right= insert(num,node.right)
    end
    node
  end

  def delete(num, node = @root)
  
    return node if node.nil?
  
    if num < node.data
      node.left = delete(num, node.left)
    elsif num > node.data
      node.right = delete(num, node.right)
    else
      # Node with num is found
      #  Node has no child or only one child
      if node.left.nil?
        temp = node.right
        node = nil
        return temp
      elsif node.right.nil?
        temp = node.left
        node = nil
        return temp
      end
  
      # Node has two children, find the inorder successor
      temp = find_min(node.right)
      # Copy the inorder successor's data to this node
      node.data = temp.data
      # Delete the inorder successor
      node.right = delete(temp.data, node.right)
    end

    node
  end

  def find(num, node=@root)
    return nil if node.nil?
    if node.data>num
    return  find(num,node.left)
    elsif node.data<num
    return find(num,node.right)
    end
    node
  end

  def level_order_itr(node=@root, &block)
    return [] if node.nil?
    result =[]
    queue =[node]
    while !queue.empty?
    current_node = queue.shift
    if block_given?
      yield current_node.data
    else
      result << current_node.data
    end
    if !current_node.left.nil?
      queue << current_node.left
    end
    if !current_node.right.nil?   
      queue << current_node.right
    end 
    end
    return result
  end

  def level_order_rec(node=@root,queue=[@root],result=[], &block)
    return result if queue.empty? 

    current_node = queue.shift
    yield current_node.data if block_given?
    result << current_node.data
    
    queue << current_node.left if current_node.left
    queue << current_node.right if current_node.right
    
    level_order_rec(queue.first, queue, result, &block)
    
  end

  def preorder(node=@root, &block)
    return [] if node.nil?
    result=[]
    if block_given?
      yield node.data
    else 
      result << node.data   
    end
    result +=preorder(node.left , &block) 
    result +=preorder(node.right, &block)
  result
  end

  def inorder(node=@root, &block)
    return [] if node.nil?
    result=[]
    result +=preorder(node.left , &block) 
    if block_given?
      yield node.data
    else 
      result << node.data   
    end
    result +=preorder(node.right, &block)
  result
  end

  def postorder(node=@root, &block)
    return [] if node.nil?
    result=[]
    result +=preorder(node.left , &block) 
    result +=preorder(node.right, &block)
    if block_given?
      yield node.data
    else 
      result << node.data   
    end
  result
  end
  private
  def find_min(node)
    current = node
    current = current.left until current.left.nil?
    current
  end
  
   
end

# bst = Tree.new([1,2,8,6,3,7,4,6,56,2,8,23,4,2,9,21,47,22,33,58,24,66,88])
bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324,444,85,2,63,84,22,47,96,33,44,88,55,22,33,77,654,982,364])
bst.pretty_print
# bst.insert(10)
# bst.pretty_print
# bst.delete(67)
# bst.delete(1)
# bst.delete(6345)
# bst.delete(9)
# bst.delete(77)
# bst.pretty_print
# ss = bst.find(99)
# bst.preorder do |node|
#   print "#{node} "
# end
# puts
# p bst.preorder

# bst.inorder do |node|
#   print "#{node} "
# end
# puts
# p bst.inorder

# bst.postorder do |node|
#   print "#{node} "
# end
# puts
# p bst.postorder

# bst.level_order_itr do |node|
#   print "#{node} "
# end

# puts ""
# p bst.level_order_itr

bst.level_order_rec do |node|
  print "#{node} "
end
puts 
p bst.level_order_rec
