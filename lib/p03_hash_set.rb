require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == @store.length
    i = key.hash % @store.length
    @store[i] << key
    @count += 1
  end

  def include?(key)
    i = key.hash % @store.length
    @store[i].include?(key)
  end

  def remove(key)
    i = key.hash % @store.length
    @store[i].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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
