module Rag
  class Aggregator
    include Enumerable
    
    attr_accessor :column, :block
    
    def initialize(column)
      self.column = column
    end
    
    def all(&block)
      self.block = block
    end
    
    def inject(start, &block)
      self.all do |data|
        data.inject(start, &block)
      end
    end
    
    def sum
      self.all do |data|
        data.inject(0) { |acc,i| acc + i.to_i }
      end
    end
  end
end