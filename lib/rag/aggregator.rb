module Rag
  class Aggregator    
    attr_accessor :column, :start, :block
    
    def initialize(column)
      self.column = column
    end
    
    # def all(&block)
    #   self.block = block
    # end
    
    def inject(start, &block)
      self.start = start
      self.block = block
    end
    
    # def sum
    #   self.all do |data|
    #     data.inject(0) { |acc,i| acc + i.to_i }
    #   end
    # end
  end
end