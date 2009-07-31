module Whitelist

  # Whitelist a hash by filtering the provided keys.
  #
  # @overload whitelist hash, :foo, :bar, :baz
  #   Returns a copy of hash with the keys provided.
  # @overload whitelist :hash, :foo, :bar, :baz
  #   Returns a copy of params[:hash] with the keys provided.
  # @example Different ways of using whitelist:
  #     params[:foo] = nil

  #     # Returns an empty hash if the value provided is nil.
  #     whitelist(params[:foo])           #=> {}

  #     params[:foo] = { :bar => 1, :baz => 2 }

  #     # Returns a copy of params[:hash] with the keys provided.
  #     whitelist(params[:foo], :bar)     #=> { :bar => 1 }

  #     # It also accepts a symbol as the first parameter, and interprets it as a key for params.
  #     whitelist(:foo, :bar)             #=> { :bar => 1 }
  #     whitelist(:foo)                   #=> {}
  def whitelist(spec, hash = params)
    spec = Array(spec) unless spec.kind_of?(Hash)

    hash.keys.each do |key|
      hash.delete(key) unless spec.include?(key)
    end

    spec.each do |key, subspec|
      whitelist(subspec, hash[key]) if subspec
    end
  end
end
