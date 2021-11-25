---
date: 9.11.2021
title: Documentation improvements
weight: 11
prev: /docs/documentation-setup
next: /docs/api-versioning
---
# Documentation improvements

In this article, we describe how you can improve your API documentation.

## Examples

Examples are priceless for the programmers. You can define any number of example values in the comment before the message definition.
```protobuf
// Some structure description
// [Example]{
//   "isbn": "978-3-16-148410-0",
//   "title": "The Shining",
//   "author": {"first_name": "Stephen", "last_name": "King"}
//}
// [Example]{"isbn": "123-213-123"}
message Book {
  string isbn = 1; 
  string title = 2;
  Author author = 3; 
}
```
All the examples are validated during the build process. The generator skips the fields without a defined value.

| Field Type | Example value | Comment |
|--| -- | -- |
| bytes | "MDIxMzQ3ODk0Ng=="" | base64 encoded value |
| string | "some-string with chars ążę©" | utf-8 encoded string|
| int32, int64, uint32, uint64, sint32, sint64, fixed32, fixed64, sfixed32, sfixed64 | 129803 | Integer value in decimal format. |
| double,  float | 3.1415 | Floating point value |
| boolean | true | might be true or false |
| enums | 1 | the numeric value of enum |
| repeated values | ["g","R","PC"] | JSON-valid lists with coma as a separator |

```java
package demo;

import io.grpc.Channel;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import gendocu.sdk_generator.v3.BookServiceGrpc;
import gendocu.sdk_generator.v3.Service;
import gendocu.sdk_generator.v3.Service.Author;
import gendocu.sdk_generator.v3.Service.Book;

public class App {
    public static void main(String[] args) {
        ManagedChannel channel = ManagedChannelBuilder
            .forAddress("library-app-grpc-uqnits2f5q-uc.a.run.app", 443)
            .usePlaintext()
            .build();
        BookServiceGrpc.BookServiceBlockingStub blockStub = BookServiceGrpc.newBlockingStub(channel);
        
        Author req_Author = Author.newBuilder()
                    .setFirstName("Stephen")
                    .setLastName("King").build();
        Book req_Book = Book.newBuilder()
                    .setAuthor(req_Author)
                    .setIsbn("978-3-16-148410-0")
                    .setTitle("The Shining").build();
        Book resp = blockStub.createBook(req_Book);
        System.out.println(resp);
/*{
  "author": {
    "first_name": "Stephen",
    "last_name": "King"
  },
  "isbn": "978-3-16-148410-0",
  "title": "The Shining"
}*/
        channel.shutdown();
    }
}

```

## Try it feature

With the try-it feature, you can call any gRPC endpoint directly from your browser. It <u>requires defining a gRPC URL</u> for the service.
We also recommend defining authentication schemes to simplify the try-it usage - more you can read [here](/docs/documentation-setup/#authentication-schemes).

We use the `grpcurl` to perform the gRPC call.

## Descriptions in the documentation

There are multiple ways of providing descriptions to the users. Our system accepts the descriptions from two sources:
1. General documentation - `gendocu_apispec.yaml`
2. gRPC-related documentation -  in `*.proto` files

### General documentation

You can define general documentation in the `documentation` > `content` field in the `gendocu_apispec.yaml`
```yaml
documentation:
  content:
    introduction:
      file: docs/introduction.md
    authentication:
      text: This API does not require authentication, but we have added a redundant auth method - Token Auth for demo purposes. You can select it and use it, but the results would be the same as without it.
```

#### Documentation content
| Field | Required | Value | Description |
| -- | -- | -- | -- |
| introduction | no | [Description object](/docs/documentation-improvements/#description-object) | The first visible bunch of text. We recommend starting it with `# h1 title`. It should be a short description of the API purpose. |
| authentication | no | [Description object](/docs/documentation-improvements/#description-object) | It is the section before the authentication method list. By default, it is empty. It can contain only titles starting from h3 (`###`). |

#### Description object
You can set only one field - `file` or `text`.

|Field| Required | Value | Description |
| -- | -- | -- | -- |
| file | no | file path | The markdown file relative to the `gendocu_apispec.yaml` file. |
| text | no | string | The string description. |

### gRPC-related documentation

All gRPC-related descriptions are fetched from the comments. Those comments should be plain-text descriptions.

```protobuf
// BookService is a simple service that enables listing, creating, or removing the book.
service BookService {
  // ListBooks returns the list of all books available in the library without any pagination.
  rpc ListBooks(google.protobuf.Empty) returns (ListBookResponse);
  // DeleteBook deletes the book from the library. Warning! This action cannot be reverted and doesn't require any confirmation.
  rpc DeleteBook(DeleteBookRequest) returns (Book);
  // CreateBook creates a book in the library. We do not de-duplicate the requests as this is the tutorial API.
  rpc CreateBook(Book) returns (Book);
}
// You can delete the books using multiple selectors
message DeleteBookRequest {
  oneof selector {
    string isbn = 1; // ISBN
    string title = 2; // Book title - exact match
  }
}
```
