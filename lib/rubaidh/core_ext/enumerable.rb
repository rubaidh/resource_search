module Enumerable
  def unzip
    size = first.nil? ? 0 : first.length
    returning Array.new(size) { [] } do |result|
      each do |tuple|
        size == tuple.size or raise "unzip with unequal length pairs"
        tuple.each_with_index do |t, i|
          result[i] << t
        end
      end
      result.last.pop if result.last.last.nil?
    end
  end
end