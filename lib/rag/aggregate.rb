module Rag
  class Aggregate    
    class << self
      attr_accessor :aggregators
      
      def output(column, &block)
        self.aggregators ||= []
        self.aggregators << Aggregator.new(column, block)
      end
    end
    
    attr_accessor :input_data
    private :input_data=
    
    def initialize(input_data)
      self.input_data = input_data
    end
    
    def aggregate
      input_array = input_data.map do |input_row|
        input_row.split(',').map {|c| c.strip.to_i } # TODO put this somewhere else
      end
      
      self.class.aggregators.map do |aggregator|
        column = input_array.map { |row| row[aggregator.column] }
        aggregator.block.call column
      end
    end
  end
end
