require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe "Rag::Aggregate" do
  describe 'output' do
    it "should yield all data to a block" do
      Foo = Class.new(Rag::Aggregate) do
        output(0) do |data|
          data.inject(0) { |acc,i| acc + i.to_i }
        end
      end
      
      agg = Foo.new("1\n2\n3")
      
      agg.aggregate.should == [[6]]
    end
    
    it 'should work when using an anonymous class' do
      foo = Class.new(Rag::Aggregate) do
        output(0) do |data|
          data.inject(0) { |acc,i| acc + i.to_i }
        end
      end
      
      agg = foo.new("1\n2\n3")
            
      agg.aggregate.should == [[6]]
    end
    
    it 'should work with 2 columns' do
      foo = Class.new(Rag::Aggregate) do
        output(0) do |data|
          data.inject(0) { |acc,i| acc + i.to_i }
        end
        
        output(1) do |data|
          data.inject(0) { |acc,i| acc + i.to_i }
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
          data.inject(0) { |acc,i| acc + i.to_i }
        end
      end
      
      agg = foo.new("foo,1\nbar,2\nbar,3")
            
      agg.aggregate.sort.should == [["foo", 1], ["bar", 5]].sort
    end
    
    it 'should work with groups with multiple items' do
      foo = Class.new(Rag::Aggregate) do
        group_by 0, 1
        output(2) do |data|
          data.inject(0) { |acc,i| acc + i.to_i }
        end
      end
      
      agg = foo.new("foo,bop,1\nbar,bop,2\nbar,bop,3\nbar,baz,4")
            
      agg.aggregate.sort.should == [["foo", "bop", 1], ["bar", "bop", 5], ["bar", "baz", 4]].sort
    end
  end
end

describe 'Rag::Array' do
  describe '#extract' do
    it "should extract the columns from the array" do
      foo = [0,1,2,3,4]
      foo.extend(Rag::Array)
      
      foo.extract_columns(1,3,4).should == [1,3,4]
    end
    
    it 'should return an empty array when supplied with no params' do
      foo = []
      foo.extend(Rag::Array)
      
      foo.extract_columns.should == []
    end
  end
end
