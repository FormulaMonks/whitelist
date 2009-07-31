Hash#bisect
===========

Adds a recursive key-based bisection to Hash. This allows you to ignore
unwanted keys from a Hash.

Description
-----------

Hash#bisect allows you to recursively bisect a hash by its keys. It is similar
to Hash#slice in ActiveSupport except that it works recursively. This can be
useful for "whitelisting" incoming parameters in a web application.

Usage
-----

     { :a => 1, :b => 2 }.bisect(:a)                 #=> { :a => 1 }
     { :a => 1, :b => 2, :c => 3 }.bisect(:a, :b)    #=> { :a => 1, :b => 2 }
     { :a => 1, :c => { :d => 3 } }.bisect(:c => :d) #=> { :c => { :d => 3 } }
     
     hash = { :a => 1, :b => 2, :c => { :d => 3, :e => { :f => 4 } } }
     
     hash.bisect(:a, { :c => { :e => :f } })         #=> { :a => 1, :c => { :e => { :f => 4 } } }
     hash.bisect({ :c => [ :d, :e ] })               #=> { :c => { :d => 3, :e => { :f => 4 } } }

Rails & ActiveRecord
--------------------

The inspiration for this came from attempting to solve a problem with
ActiveRecord:

It's a very common pattern to forbid access to key attributes in models.
One obvious example is ActiveRecord's use of the attr_accessible
decorator.

The problem with ActiveRecord's approach is that it assumes you want the
same restrictions to apply for every context, which is not always the
case. A common scenario is to have different access levels for different
kinds of users, or higher restrictions for user generated data and a
lower barrier for developer generated data.

Hash#bisect allows you to recursively filter params at the controller level,
allowing your controllers to define the context for which parameters they will
accept.

For example:

    @car = Car.new(params[:car].bisect(:color))
    
Will strip everything from `params[:car]` except the `:color` attribute
    
With nested attributes:
    
    @car = Car.new(params[:car].bisect(:color, { :driver_attributes => [ :name, :height ] }))
    
Will strip everything from `params[:car]` except `:color` and 
`:driver_attributes`, as well as stripping everything but `:name` & `:height`
from `:driver_attributes`.

With deeply nested attributes:

    @car = Car.new(params[:car].bisect(:color, { :drivers_attributes => { '0' => [ :name, :height ] } }))

Installation
------------

    $ sudo gem install bisect

Contributors
------------

* Ben Alavi (benalavi)
* Michel Martens (soveran)
* Damian Janowski (djanowski)

License
-------

Copyright (c) 2009 Ben Alavi for Citrusbyte

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
