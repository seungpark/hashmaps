class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    results = 0
    self.each_with_index do |val, index|
      results += val.hash ^ index.hash
    end
    results
  end
end

class String
  def hash
    self.split("").map { |el| el.ord }.join("").to_i
  end
end

class Hash
  def hash
    results = 0
    self.sort.each do |key, val|
      results += key.hash ^ val.hash
    end
    results
  end
end
