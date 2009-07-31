module Bisect
  # Whitelist a hash by filtering the provided keys.
  #
  # @overload whitelist hash, :foo, :bar, :baz
  #   Returns a copy of hash with the keys provided.
  # 
  # @overload whitelist :hash, :foo, :bar, :baz
  #   Returns a copy of params[:hash] with the keys provided.
  # 
  # @example Different ways of using whitelist:
  # 
  #     params[:foo] = nil
  #     # Returns an empty hash if the value provided is nil.
  #     whitelist(params[:foo])           #=> {}
  #     params[:foo] = { :bar => 1, :baz => 2 }
  #     # Returns a copy of params[:hash] with the keys provided.
  #     whitelist(params[:foo], :bar)     #=> { :bar => 1 }
  #
  #     # It also accepts a symbol as the first parameter, and interprets it as a key for params.
  #     whitelist(:foo, :bar)             #=> { :bar => 1 }
  #     whitelist(:foo)                   #=> {}
  def bisect(keys)
    result = Hash.new
    keys   = [keys] unless keys.is_a?(Array)
    
    keys.each do |key|
      key.to_a.each{ |k| result[k[0]] = self[k[0]].bisect(k[1]) } if key.is_a?(Hash)
      next unless member?(key)
      result[key] = self[key]
    end
    result
  end
end

Hash.send(:include, Bisect)