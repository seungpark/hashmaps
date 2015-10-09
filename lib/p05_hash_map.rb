require_relative 'p02_hashing'
require_relative 'p04_linked_list'
include Enumerable

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    i = key.hash % @store.length
    @store[i].include?(key)
  end

  def set(key, val)   #inserting
    if @count == num_buckets
      resize!
      i = key.hash % num_buckets
      @store[i].insert(key, val)
      @count += 1
    else
      i = key.hash % num_buckets
      @store[i].insert(key, val)
      @count += 1
    end
  end

  def get(key)  #fetch a bucket
    i = key.hash % num_buckets
    @store[i].get(key)
  end

  def delete(key)
    i = key.hash % num_buckets
    @store[i].remove(key)
    @count -= 1
  end

  def each(&prc)
    i = 0
    while i < num_buckets
      @store[i].each { |link| prc.call(link.key,link.value) }
      i += 1
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(2 * @store.length){ LinkedList.new }
    @store.flatten.each do |linked_list|
      linked_list.each do |item|
        i = item.key.hash % new_store.length
        new_store[i].insert(item.key, item.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end

hash = HashMap.new
hash.set(:first, 1)
hash.set(:second, 2)
hash.set(:third, 3)
hash
