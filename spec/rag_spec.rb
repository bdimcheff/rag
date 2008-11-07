require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe "Rag::Aggregate" do
  describe 'output' do
    it "should yield all data to a block" do
      Foo = Class.new(Rag::Aggregate) do
        output(0) do |data|
          data.inject(0) { |acc,i| acc + i }
        end
      end
      
      agg = Foo.new("1\n2\n3")
      
      agg.aggregate.should == [[6]]
    end
    
    it 'should work when using an anonymous class' do
      foo = Class.new(Rag::Aggregate) do
        output(0) do |data|
          data.inject(0) { |acc,i| acc + i }
        end
      end
      
      agg = foo.new("1\n2\n3")
            
      agg.aggregate.should == [[6]]
    end
    
    it 'should work with 2 columns' do
      foo = Class.new(Rag::Aggregate) do
        output(0) do |data|
          data.inject(0) { |acc,i| acc + i }
        end
        
        output(1) do |data|
          data.inject(0) { |acc,i| acc + i }
        end
      end
      
      agg = foo.new("1,2\n2,4\n3,6")
            
      agg.aggregate.should == [[6,12]]
    end
  end
  
  describe 'group_by' do
    it "should separate aggregates into groups" do
      foo = Class.new(Rag::Aggregate) do
        group_by 0
        output(1) do |data|
          data.inject(0) { |acc,i| acc + i }
        end
      end
      
      agg = foo.new("foo,1\nbar,2\nbar,3")
            
      agg.aggregate.should == [["foo", 1], ["bar", 5]]
    end
  end
end
