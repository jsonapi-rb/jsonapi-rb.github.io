---
layout: guides
---
# Serialization - Rendering documents

The renderer takes your business objects (which can be any ruby objects: POROs,
ActiveRecord models, or even plain hashes), along with some optional parameters
(`include`, `fields`, etc.), and builds the JSON API document.

The available global options are:

+ serializable resource class related options:
  + `class`: a hash globally mapping model class names to serializable resource
     class names.
+ top level properties:
  + `links`: a set of top level links. This option can be specified as a hash.
  + `meta`: top level meta information. This option can be specified as a hash.
  + `jsonapi`: top level `jsonapi` object. This option can be specified as a
    hash.
+ framework-specific options: in Hanami and Rails, the usual options such as
`status` are respected.

When serializing resources and relationships, the following
data-related options are also available:

+ `include`: the related resources to include in the document. This option can
  be specified as a string (e.g. `"author,comments.author"`), or as an array/
  hash of symbols (e.g. `[:author, comments: [:author]]`).
+ `fields`: a restricted set of fields for some or all resources. This option
  can be specified as a hash of arrays of symbols (e.g.
  `{ users: [:name, :email], posts: [:title, :content] }`).
+ `expose`: a hash of arbitrary variables that will be made available to the
  serializable resources as instance variables.
+ `cache`: a cache supporting `fetch_multi` for fragment caching.
