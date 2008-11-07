require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe "Rag::Aggregate" do
  describe 'output' do
    it "should yield all data to a block" do
      agg_klass = Class.new(Rag::Aggregate) do
        output(1) do |data|
          data
        end
      end
      
      agg = agg_klass.new("1\n2\n3")
      
      agg.aggregate.should == [[1,2,3]]
    end
    
    
  end  
end
