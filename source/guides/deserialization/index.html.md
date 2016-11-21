---
layout: guides
---
# Deserialization

In order to build custom hashes from JSON API payloads, you need to define some
*deserializable resources*. Deserializable resources map the members of a
payload to fields of a hash. They are defined via an intuitive DSL.

Once your deserializable resources are defined, you can call them on hashes
representing input JSON API payloads, and obtain a hash that you can use
directly to create/update your models.

- [Defining deserializable resources](guides/deserialization/defining.html)
- [Deserializing payloads](guides/deserialization/deserializing.html)
