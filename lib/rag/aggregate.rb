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
      # look up block for each group and aggregate
      
      input_data.each do |input_row|
        input_array = input_row.split(',').map {|c| c.strip } # TODO put this somewhere else, support more formats
        input_array.extend(Rag::Array)
        row_group = input_array.extract_columns(*(self.class.grouping))
        
        self.class.aggregators.each do |aggregator|
          self.aggregates[[row_group, aggregator]] ||= aggregator.start
          
          aggregator.block.call(input_array[aggregator.column])
          
          # aggregator_block = self.aggregates[[row_group, aggregator]] ||= lambda do |acc, row|
          #   # inject into aggregator block
          #   memo = aggregator.start
          #   aggregator.block.call(acc, row)
          # end
          
          aggregator_block.call(input_array[aggregator.column])
        end
      end
      
      
    end
    
    # def aggregate
    #   parse_input
    #   
    #   groups.map do |group, group_values|
    #     group_results = self.class.aggregators.map do |aggregator|
    #       column = group_values.map { |row| row[aggregator.column] }  # TODO this is slow
    #       aggregator.block.call column
    #     end
    #     group + group_results
    #   end
    # end
    # 
    # private
    # def parse_input
    #   grouping = self.class.grouping || []
    # 
    #   input_data.map do |input_row|
    #     input_array = input_row.split(',').map {|c| c.strip } # TODO put this somewhere else, support more formats
    #     input_array.extend(Rag::Array)
    #     
    #     row_group = input_array.extract_columns(*grouping)
    # 
    #     group_data = self.groups[row_group] ||= []
    #     group_data << input_array
    #   end
    # end
  end
end
