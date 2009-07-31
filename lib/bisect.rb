module Bisect
  # Returns a new hash which is the key-based bisection of this hash and the
  # given collection of keys. That is, it is the original hash with all the
  # keys not present in the given collection of keys removed.
  # 
  # The collection of keys can be a single key, an list of keys, a hash itself,
  # or a list of hashes and keys. Note that it only does a *key* bisection, so
  # the hash is more like a cleaner way to express an array of keys.
  # 
  # The bisection works recursively.
  #
  # @example Different ways of using bisect:
  # 
  #     { :a => 1, :b => 2 }.bisect(:a)                 #=> { :a => 1 }
  #     { :a => 1, :b => 2, :c => 3 }.bisect(:a, :b)    #=> { :a => 1, :b => 2 }
  #     { :a => 1, :c => { :d => 3 } }.bisect(:c => :d) #=> { :c => { :d => 3 } }
  #     { :a => 1, :b => 2, :c => { :d => 3, :e => { :f => 4 } } }.bisect(:a, { :c => { :e => :f } }) #=> { :a => 1, :c => { :e => { :f => 4 } } }
  #     { :a => 1, :b => 2, :c => { :d => 3, :e => { :f => 4 } } }.bisect({ :c => [ :d, :e ] })       #=> { :c => { :d => 3, :e => { :f => 4 } } }
  # 
  def bisect(*keys)
    result = self.class.new    
    keys.each do |key|
      key.each do |k| 
        result[k[0]] = (k[1].is_a?(Hash) ? self[k[0]].bisect(k[1]) : self[k[0]].bisect(*k[1]))
      end if key.is_a?(Hash)
      next unless member?(key)
      result[key] = self[key]
    end
    result
  end
end

Hash.send(:include, Bisect)