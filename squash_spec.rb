require 'pry'
require 'rspec'
require_relative 'squash.rb'

describe Squash do
  
  context "Happy Path" do 
    it "Example One" do
      in_array = [[1,2,[3]],4]
      out_array = [1,2,3,4]
      
      expect(Squash.run(in_array)).to eq(out_array)
    end
    
    it "Example Two" do
      in_array = [[1, 2, [3, [4]]], [5], 6, [[[[7, [8]], 9]], 10]]
      out_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
      
      expect(Squash.run(in_array)).to eq(out_array)
    end
    
    it "Example Three" do
      in_array = [
        [1, [2, "a"]], 3, [[4], 5, ["b", [6]]], [[[[[7]]]], 
        [[[[{key: 'value'}, [[[[8]]]]], true]]]], [[9, [10]], nil],
        [1, [2, "a"]], 3, [[4], 5, ["b", [6]]], [[[[[7]]]], 
        [[[[{key: 'value'}, [[[[8]]]]]]]], false], [[9, [10]], nil],
        [[[[[1,2,3,4,5], 4], 5], 6], 7],
        {key_2: "value 2"},
        [[[[[]]]]],
        "xxx"
      ]
      
      out_array = [1, 2, "a", 3, 4, 5, "b", 6, 7, {:key=>"value"}, 
                   8, true, 9, 10, nil, 1, 2, "a", 3, 4, 5, "b", 
                   6, 7, {:key=>"value"}, 8, false, 9, 10, nil, 1, 
                   2, 3, 4, 5, 4, 5, 6, 7, {:key_2=>"value 2"}, "xxx"]
      
      expect(Squash.run(in_array)).to eq(out_array)
    end
  end
  
  context "Sad Path" do 
    it "raises error when trying to flatten 'String'" do
      message = "Expecting 'Array', but instead got 'String'"
      expect{ Squash.run("a") }.to raise_error(ArgumentError, message)
    end
    
    it "raises error when trying to flatten 'Hash'" do
      message = "Expecting 'Array', but instead got 'Hash'"
      expect{ Squash.run({key: "value"}) }.to raise_error(ArgumentError, message)
    end
    
    it "raises error when trying to flatten 'Symbol'" do
      message = "Expecting 'Array', but instead got 'Symbol'"
      expect{ Squash.run(:symbol) }.to raise_error(ArgumentError, message)
    end
    
    it "raises error when trying to flatten 'Nil'" do
      message = "Expecting 'Array', but instead got 'NilClass'"
      expect{ Squash.run(nil) }.to raise_error(ArgumentError, message)
    end
  end
  
end