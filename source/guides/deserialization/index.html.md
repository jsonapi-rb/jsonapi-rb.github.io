---
layout: guides
---
# Deserialization

Any resource payload can be deserialized into a standardized format using the
`JSONAPI::Deserializable::Resource` class. In case you need more control over
the generated hash (modifying some field names, or modifying the default
deserialization scheme for attributes/relationships), you can define custom
*deserializable resources*. Deserializable resources map the members of a
payload to fields of a hash. They are defined via an intuitive DSL.

Once your deserializable resources are defined, you can call them on hashes
representing input JSON API payloads, and obtain a hash that you can use
directly to create/update your models.

- [Defining deserializable resources](guides/deserialization/defining.html)
- [Deserializing payloads](guides/deserialization/deserializing.html)
