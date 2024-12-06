require_relative("../project_linked_list/linked_list")
class HashMap
  attr_accessor :load_factor, :capacity, :buckets, :length

  def initialize
    @load_factor = 0.75
    @capacity = 16
    create_bucket(@capacity)
    @length = 0
  end

  def create_bucket(capacity)
    @buckets = []
    capacity.times {|i| @buckets << LinkedList.new}
  end

  def hash(key)
    hash_code = 0
    prime_number = 31 
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code % capacity
  end

  def set(key, value)
    hash_code = hash(key)
    raise IndexError if hash_code.negative? || hash_code >= @buckets.length
    list = @buckets[hash_code]
    index = list.find_key(key)
    unless index.nil?
      list.remove_at(index)
      @length -= 1
    end
    list.append([key, value])
    @length += 1
    resize if @length > @capacity * @load_factor
  end

  def get(key)
    hash_code = hash(key)
    raise IndexError if hash_code.negative? || hash_code >= @buckets.length
    list = @buckets[hash_code]
    index = list.find_key(key)
    return "Key doesn't exist in the bucket" if index.nil?
    list.at(index).value[1]
  end

  def has?(key)
    hash_code = hash(key)
    raise IndexError if hash_code.negative? || hash_code >= @buckets.length
    list = @buckets[hash_code]
    index = list.find_key(key)
    !index.nil?
  end

  def remove(key)
    hash_code = hash(key)
    raise IndexError if hash_code.negative? || hash_code >= @buckets.length
    list = @buckets[hash_code]
    index = list.find_key(key)
    return index if index.nil?
    value = list.at(index).value[1]
    list.remove_at(index)
    @length -= 1
    return value
  end

  def keys
    key_list = []
    @buckets.each do |list|
      list.size.times do |index|
        key_list.push(list.at(index).value[0])
      end
    end
    key_list
  end

  def values
    value_list = []
    @buckets.each do |list|
      list.size.times do |index|
        value_list.push(list.at(index).value[1])
      end
    end
    value_list
  end

  def entries
    entry_list = []
    @buckets.each do |list|
      list.size.times do |index|
        entry_list.push(list.at(index).value)
      end
    end
    entry_list
  end

  def clear
    @length = 0
    create_bucket(@capacity)
  end

  def resize
    current_entries = entries
    @capacity *= 2
    clear
    current_entries.each do |key, value|
      set(key, value)
    end
  end
 
end

test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
test.set('lion', 'golden')
test.set('moon', 'silver')
test.get("moon")
test.has?("thousand")
test.remove("elephant")
p test.values
p test.keys