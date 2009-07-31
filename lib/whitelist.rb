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
  def whitelist(hash, *keys)
    return {} if hash.nil?
    return {} if keys.empty?
    return whitelist(params[hash], *keys) if hash.is_a?(Symbol)

    result = Hash.new
    keys.each do |key|
      next unless hash.member?(key)
      result[key] = hash[key]
    end
    result
  end
end
