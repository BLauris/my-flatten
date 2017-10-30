class Squash
  
  class << self
    def run(object)
      unless object.is_a?(Array)
        raise ArgumentError.new("Expecting 'Array', but instead got '#{object.class.name}'")
      end
      
      recursively_flatten(object)
    end

    private
      
      def recursively_flatten(object)
        object.each_with_object([]) do |element, result|
          if element.is_a?(Array)
            result.concat(recursively_flatten(element))
          else
            result << element
          end
        end
      end
  end
  
end