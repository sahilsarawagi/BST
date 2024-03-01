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

 
end

# bst = Tree.new([1,2,8,6,3,7,4,6,56,2,8,23,4,2,9,21,47,22,33,58,24,66,88])
bst = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
bst.pretty_print
