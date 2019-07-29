# README

# create a n-deep data structure from simple associations; render recursively with a partial

* System dependencies
  - csv gem

* Database initialization
  - seed from CSV

* Services (job queues, cache servers, search engines, etc.)
  - creates nested_hash, in preparation for render
  - uses an object class called Pointer, to keep an index of data items

