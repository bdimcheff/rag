module Rag
  class Aggregator    
    attr_accessor :column, :start, :block
    
    def initialize(column)
      self.column = column
    end
    
    def inject(start, &block)
      self.start = start
      self.block = block
    end
    
    # TODO: make this work with streaming somehow
    # def all(&block)
    #   self.start = []
    #   self.block = block
    # end
    
    def sum
      self.inject(0) {|acc, i| acc + i.to_i}
    end
  end
end