---
layout: guides
---
# Introduction

## What is jsonapi-rb?
[jsonapi-rb](https://github.com/jsonapi-rb/jsonapi-rb) is a ruby library for
producing and consuming [JSON API](http://jsonapi.org) documents. It is cleanly
layered, has an intuitive yet intent-stating API, and no magic.

It is comprised of 4 independent micro-libraries:

+ [jsonapi-parser](https://github.com/jsonapi-rb/parser) for syntactic
validation of JSON API documents,
+ [jsonapi-renderer](https://github.com/jsonapi-rb/renderer) for low-level
rendering of JSON API documents,
+ [jsonapi-serializable](https://github.com/jsonapi-rb/serializable) for
building serializable resource classes from your business object -- those are
usually referred to as "serializers" in other libs,
+ [jsonapi-deserializable](https://github.com/jsonapi-rb/deserializable) for
building deserializable resource classes that transform an incoming JSON API
payload into a custom hash,

and 2 framework integrations:

+ [jsonapi-rails](https://github.com/jsonapi-rb/rails) for
[Ruby on Rails](http://rubyonrails.org), with ActionController integration and
generators,
+ [jsonapi-hanami](https://github.com/jsonapi-rb/hanami) for
[Hanami](http://hanamirb.org) with Hanami::Controller::Action integration and
(soon) generators.

## Guides

These guides should get you up to speed with using jsonapi-rb. If you have more
questions, feel free to drop by on [Gitter](http://gitter.im/jsonapi-rb).

+ [Serialization](/guides/serialization)
+ [Deserialization](/guides/deserialization)
