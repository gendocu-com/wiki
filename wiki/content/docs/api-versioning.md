---
date: 14.07.2021
title: API Versioning
weight: 21
prev: /docs/general-concepts
---
# API Versioning

The preferred approach uses semantic versioning like
described [in the gRPC Documentation](https://grpc.github.io/grpc/core/md_doc_versioning.html).

## Endpoints Versioning
To maintain this concept you should use your directory structure. Every major version (breaking change) should have separate directory, like:

```bash
/money
  /v1
    /MoneyService.proto
  /v2
    /MoneyService.proto
    /Accounting.proto
  /v3
    /MoneyService.proto
```

In that way, your clients can select the API version they want to use (possibly the newest) and have an easy and safe
way to migrate to a more recent version.

A great example is the [Google APIs Repository](https://github.com/googleapis/googleapis).

## The API definition versioning

The API definition (the proto files containing the API definition) should be stored in the git repository.
You should version your API using git tags like `git tag v1.1.0`. GenDocu, in the future, will apply those tags also to the 
SDK repository and enhance your documentation users to use it. As for now, all your users should pin to a specific SDK repository commit.


