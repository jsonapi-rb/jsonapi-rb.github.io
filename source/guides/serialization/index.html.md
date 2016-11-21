---
layout: guides
---
# Serialization

In order to build JSON API documents from your data, you need to define some
*serializable resources*. Serializable resources encapsulate your domain objects
(which can be any kind of objects) and present them in a suitable way for JSON
API serialization. They are defined via an intuitive yet extensive DSL.

Once your serializable resources are defined, you can pass your business objects
to the *renderer*, that will build the appropriate serializable resources, and
render them into a JSON API document.

- [Defining serializable resources](guides/serialization/defining.html)
- [Rendering JSON API documents](guides/serialization/rendering.html)
