module Rag
  class Aggregator
    attr_accessor :column, :block
    
    def initialize(column, block)
      self.column, self.block = column, block
    end
  end
end