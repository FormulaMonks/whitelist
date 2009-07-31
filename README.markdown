Whitelist
=======

Easy to use filter for parameter hashes.

Description
-----------

Whitelist helps you filter a parameters hash to get only the values you
care about.

It's a very common pattern to forbid access to key attributes in models.
One obvious example is ActiveRecord's use of the attr_accessible
decorator.

The problem with ActiveRecord's approach is that it assumes you want the
same restrictions to apply for every context, which is not always the
case. A common scenario is to have different access levels for different
kinds of users, or higher restrictions for user generated data and a
lower barrier for developer generated data.

Whitelist approaches this problem by providing a simple mechanism for
filtering hashes, with some fair assumptions to abstract recurring
patterns.

Usage
-----

    params[:foo] = nil

    # Returns an empty hash if the value provided is nil.
    whitelist(params[:foo])           #=> {}

    params[:foo] = { :bar => 1, :baz => 2 }

    # Returns a copy of params[:hash] with the keys provided.
    whitelist(params[:foo], :bar)     #=> { :bar => 1 }

    # It also accepts a symbol as the first parameter, and interprets it as a key for params.
    whitelist(:foo, :bar)             #=> { :bar => 1 }
    whitelist(:foo)                   #=> {}

Installation
------------

    $ sudo gem install whitelist

License
-------

Copyright (c) 2009 Ben Alavi

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
