class LinkedList
  attr_accessor :head, :tail, :size
  
  def initialize
    @head = nil
    @tail = nil
    @size = 0 
  end

  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = @tail = new_node
    else
      temp = head
      while temp
        if temp.next_node.nil?
          temp.next_node = new_node
          @tail = new_node
          break
        end
        temp = temp.next_node
      end
    end
    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = @tail = new_node 
    else
      new_node.next_node = @head
      @head = new_node
    end
    @size += 1
  end

  def at(index)
    return "empty" if @head.nil?
    return "index out of bounds" if index > size - 1
    temp = head
    (0...index).each {|i| temp = temp.next_node}
    temp
  end

  def pop
    return "empty" if @head.nil?
    temp = head
    while temp
      if (temp.next_node == @tail)
        temp.next_node = nil
        @tail.value = temp.value
        @size -= 1
        break
      end
      temp = temp.next_node
    end
  end

  def contains?(value)
    return "empty" if @head.nil?
    temp = head
    while temp
      return true if temp.value == value
      temp = temp.next_node
    end
  end

  def find(value)
    return "empty" if @head.nil?
    temp = head
    (0...size).each do |i|
        return i if temp.value == value
        temp = temp.next_node
    end
  end

  def insert_at(value, index)
    new_node = Node.new(value)
    return @head = new_node if @head.nil?
    temp = at(index - 1)
    new_node.next_node = temp.next_node
    temp.next_node = new_node
    @size +=1
  end

  def remove_at(index)
    return "Nothing to pop" if head.nil?
    temp = at(index - 1)
    temp.next_node = temp.next_node&.next_node
    @tail = temp if temp.next_node.nil?
    @size -= 1
    temp
  end

  def to_s
    temp = head
    while !(temp.nil?)
      print "(#{temp.value}) -> "
      temp = temp.next_node
    end
  end

  def find_key(key)
    return nil if size < 1
    temp = head
    index = 0
    until temp.next_node.nil?
      return index if temp.value[0] == key
      temp = temp.next_node
      index += 1
    end
    return index if temp.value[0] == key
  end

end


class Node
  attr_accessor :value, :next_node
  def initialize(value = nil , next_node = nil)
    @value = value
    @next_node = next_node
  end
end

listing = LinkedList.new
listing.append([10,20])
listing.append(20)
listing.append(30)
listing.append(40)
listing.append(50)
listing.prepend(5)
listing.size
listing.head
listing.tail
listing.at(1)
listing.pop
listing.contains?(75)
listing.find(30)
listing.insert_at(3, 2)
listing.remove_at(4)
# puts listing