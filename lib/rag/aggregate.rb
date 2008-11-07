module Rag
  class Aggregate    
    class << self
      attr_accessor :aggregators
      
      def initialize
        aggregators = []
      end
      
      def output(column, &block)
        aggregators_for_column = aggregators[column] ||= []
        
        aggregators_for_column << block 
      end
    end
    
    attr_accessor :input_data
    private :input_data=
    
    def initialize(input_data)
      self.input_data = input_data
    end
    
    def aggregate
      
    end
  end
end