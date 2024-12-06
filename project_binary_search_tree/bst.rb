class Node
  attr_accessor :left, :right, :value

  def initialize (value = nil)
    @value = value
    @left = nil 
    @right = nil 
  end

end

class Tree
  attr_accessor :root

  def initialize(arr = [])
    @root = build_tree(arr.sort.uniq)
  end

  def build_tree(arr, start = 0, end_indx = (arr.length)/2)
    return nil if start > end_indx
    mid = (end_indx + start)/2
    current_root = Node.new(arr[mid])
    current_root.left = build_tree(arr, start, mid - 1 )
    current_root.right = build_tree(arr, mid + 1, end_indx)
    current_root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, root = @root)
    return Node.new(value) if root.nil?
    return root if root.value == value
    if value < root.value
      root.left = insert(value, root.left)
    else
      root.right = insert(value, root.right)
    end
    root
  end

  def remove(value, root = @root)
    return nil? if root.nil?
    p 
    if value > root.value
      root.right = remove(value, root.right)
    elsif value < root.value
      root.left = remove(value, root.left)
    elsif root.left.nil? && root.right.nil?
      return nil
    elsif root.left.nil?
      root = root.right
    elsif root.right.nil?
      root = root.left
    else
      sub_min_tree = min_tree(root.right)
      root.value = sub_min_tree.value
      root.right = remove(sub_min_tree.value, root.right)
    end 
    root
  end

  def min_tree(curr_node)
    curr_node = curr_node.left until curr_node.left.nil?
    curr_node
  end

  def find(value, root = @root)
    return nil if root.nil?
    loop do
      if value < root.value
        root = root.left
      elsif value > root.value
        root = root.right
      else
        return root
      end
    end
  end

  def height(node = @root)
    return 0 if node.nil?
    left_node = height(node.left)
    right_node = height(node.right)
    [left_node, right_node].max + 1
  end

  def depth(node)
    curr_node = @root
    depth = 0
    until node.value == curr_node.value || curr_node.nil?
      curr_node = curr_node.value > node.value ? curr_node.left : curr_node.right
      depth += 1
    end
    depth
  end

  def level_order
    return nil if root.nil?
    result = []
    queue = [root]
    until queue.empty?
      curr_node = queue[-1]
      result.push(curr_node.value)
      queue.prepend(curr_node.left) unless curr_node.left.nil?
      queue.prepend(curr_node.right) unless curr_node.right.nil?
      queue.pop
    end
    result
  end

  def pre_order(root = @root, arr = [])
    return nil if root.nil?
    arr.push(root.value)
    preorder(root.left)
    preorder(root.right)
    arr
  end

  def in_order(root = @root, arr = [])
    return nil if root.nil?
    in_order(root.left)
    arr.push(root.value)
    in_order(root.right)
    arr
  end

  def post_order(root = @root, arr = [])
    return nil if root.nil?
    post_order(root.left)
    post_order(root.right)
    arr.push(root.value)
    arr
  end

  def balanced?(node = @root)
    return true if node.nil?
    left_height = height(node.left)
    right_height = height(node.right)
    return false if (left_height - right_height).abs > 1
    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    @root = build_tree(pre_order)
  end
 
end

test = Tree.new(Array.new(16) { rand(1..100) })
test.insert(56)
test.insert(47)
test.insert(50)
test.insert(40)
test.insert(78)
# test.pretty_print
test.remove(56)
# test.pretty_print 
test.find(78)
test.height
# test.depth(nil)
test.pretty_print
test.level_order
p test.root