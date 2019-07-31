# create an n-deep data structure from simple associations; render recursively with a partial

* System dependencies
  - csv gem

* Database initialization
  - seed from CSV

* Services (job queues, cache servers, search engines, etc.)
  - creates nested_hash, in preparation for render
  - uses an index (array) of hash objects to avoid nested traversals—— traversals and index for data-structure mutation purposes

* Template
  - render nested structure in HTML unordered lists: \<ul\> \<li\> \<ul\> ...
