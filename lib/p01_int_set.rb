class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num < @store.length && num > 0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num % @store.length
    @store[i] << num
  end

  def remove(num)
    @store[num].delete(num)
  end

  def include?(num)
    i = num % @store.length
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % @store.length
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == @store.length
    i = num % @store.length
    @store[i] << num
    @count += 1
  end

  def remove(num)
    @store[num].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[num % @store.length].include?(num)
  end
# This is constant time since on average each bucket has only one element
  private

  def [](num)
    num % @store.length
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(@store.length + 1){ [] }
    @store.flatten.each do |el|
      i = el % new_store.length
      new_store[i] << el
    end
    @store = new_store
  end
end
