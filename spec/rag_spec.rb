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
      
      agg.aggregate.should == [6]
    end
    
    it 'should work when using an anonymous class' do
      foo = Class.new(Rag::Aggregate) do
        output(0) do |data|
          data.inject(0) { |acc,i| acc + i }
        end
      end
      
      agg = foo.new("1\n2\n3")
            
      agg.aggregate.should == [6]
    end
  end  
end
