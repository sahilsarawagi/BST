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
bst.delete(77)
bst.pretty_print