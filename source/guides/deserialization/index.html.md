---
layout: guides
---
# Deserialization

Deserializable resources map the members of a payload to fields of a hash.
They are defined by subclassing `JSONAPI::Deserializable::Resource` via an
intuitive DSL.

Once your deserializable resources are defined, you can call them on hashes
representing input JSON API payloads, and obtain a hash that you can use
directly to create/update your models.

- [Defining deserializable resources](/guides/deserialization/defining.html)
- [Deserializing payloads](/guides/deserialization/deserializing.html)
