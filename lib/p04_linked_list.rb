include Enumerable


class Link
  attr_accessor :key, :val, :next

  def initialize(key = nil, val = nil, nxt = nil)
    @key, @val, @next = key, val, nxt
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  attr_reader :head

  def initialize
    @head = Link.new
  end

  # linkedlist[i]
  # linkedlist[0] == @head
  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    return @head if @head.next.nil?
    next_link = @head
    until next_link.next == nil
      next_link = next_link.next
    end
    next_link
  end

  def empty?
    @head.nil?
  end

  def get(key)
    return last.val if last.key == key
    test_link = @head
    while test_link.next
      if test_link.key == key
        return test_link.val
      else
        test_link = test_link.next
      end
      return nil if test_link.next == nil
    end
    nil
  end

  def include?(key)
    return true if @head.key == key
    next_link = @head
    until next_link.next == nil
      next_link = next_link.next
      return true if next_link.key == key
    end
    false
  end

  def insert(key, val)
    new_link = Link.new(key,val,nil)
    last.next = new_link
  end

  def remove(key)
    if @head.key == key
      @head = @head.next
      return
    end

    test_link = @head
    while test_link.next
      if test_link.next.key == key
        test_link.next = test_link.next.next
        break
      else
        test_link = test_link.next
      end
    end

  end

  def each(&prc)
    test_link = @head.next
    while test_link
      prc.call(test_link)
      test_link = test_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
#
# list = LinkedList.new
# list.insert(:first, 1)
# list.insert(:second, 2)
# list.insert(:third, 3)
# i = 0
# vals = (1..3).to_a
# list.each do |link|
