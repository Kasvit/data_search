# add custom methods for array
class Array
  # collect data from objects into arrays
  def pluck(*args)
    self.collect do |e|
      object_data = []
      args.each do |arg|
        object_data << e.send(arg)
      end
      object_data
    end.flatten
  end

  # similar to AR .find_by, case insensitive
  def find_by(hash)
    self.select do |e|
      result = []
      hash.each do |k, v|
        result << (e.send(k).downcase == v.downcase)
      end
      result.all? {|r| r == true }
    end
  end

  # return all elements where exact matches by key values, case insensitive
  def exact_where(hash)
    self.select do |e|
      result = []
      hash.each do |k, v|
        v = v.class == Array ? v : v.split
        result << (v.all? { |word| e.send(k).downcase.include? word.downcase })
      end
      result.all? {|r| r == true }
    end
  end

  # return all elements where at least one match by key values, case insensitive
  def where(hash)
    self.select do |e|
      result = []
      hash.each do |k, v|
        v = v.class == Array ? v : v.split
        result << (v.any? { |word| e.send(k).downcase.include? word.downcase })
      end
      result.any? {|r| r == true }
    end
  end
end
