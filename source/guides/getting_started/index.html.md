---
layout: guides
---
# Getting started

jsonapi-rb works by defining *serializable resources* for your business objects,
which describe how to serialize a model of a given type in a given serialization
context.

The *renderer* then builds a JSON API document from your business objects.
In order to do so, it needs to find for each type of model the corresponding
serializable resource class, instantiate it, and then combine all the JSON API
representations of isolated resources.

Some context can be forwarded to the serializable resources: the *exposures*,
specified when calling the renderer, are available within the serializable
resource as instance variables.

- [Plain Ruby](/guides/getting_started/plain_ruby.html)
- [Ruby on Rails](/guides/getting_started/rails.html)
- [Hanami](/guides/getting_started/hanami.html)
- [Sinatra](/guides/getting_started/sinatra.html)
