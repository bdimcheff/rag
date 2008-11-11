module Rag
  class Aggregate    
    class << self
      attr_accessor :aggregators
      attr_accessor :grouping
      
      def output(column)
        self.aggregators ||= []
        
        aggregator = Aggregator.new(column)
        
        self.aggregators << aggregator
        
        aggregator
      end
      
      def group_by(*args)
        self.grouping = args
      end
    end
    
    attr_accessor :input_data, :aggregates
    private :input_data=
    
    def initialize(input_data)
      self.input_data = input_data
      self.aggregates = {}
    end
    
    def aggregate
      build_aggregates
                  
      self.aggregates.inject({}) do |acc, (row_group, group_aggregators)|
        acc[row_group] ||= row_group.dup
        
        self.class.aggregators.each do |aggregator|
          aggregate = group_aggregators[aggregator]
          
          acc[row_group] << aggregate
        end
        
        acc
      end.values
    end
    
    def build_aggregates
      # look up block for each group and aggregate
      grouping = self.class.grouping || []
      
      input_data.each do |input_row|
        input_array = input_row.split(',').map {|c| c.strip } # TODO put this somewhere else, support more formats
        input_array.extend(Rag::Array)
        row_group = input_array.extract_columns(*grouping)
        
        self.class.aggregators.each do |aggregator|
          group = self.aggregates[row_group] ||= {}
          aggregate = group[aggregator] ||= aggregator.start
          
          self.aggregates[row_group][aggregator] = aggregator.block.call(aggregate, input_array[aggregator.column])
        end
      end
    end
  end
end
