---
date: 9.11.2021
title: Providing Additional gRPC API information
weight: 10
next: /docs/documentation-improvements
---

# Providing gRPC API information to GenDocu Generator

gRPC standard doesn't define any way of describing environments or authentication. That's why you have to create a custom api description file.
To enable all the API-related features you need:
1. Define the gRPC services URLs
2. Define authentication scheme

You can find example file [`gendocu_apispec.yaml` here](https://github.com/gendocu-com-examples/library-app/blob/master/proto/gendocu_apispec.yaml).

## GenDocu API specification file

Our tool uses a special config file `gendocu_apispec.yaml` to read properties not described in the protobuf files. You can locate it anywhere. We suggest creating it in the repository root or protoc root.
You can find the example [`gendocu_apispec.yaml` here](https://github.com/gendocu-com-examples/library-app/blob/master/proto/gendocu_apispec.yaml).

## Service URLs

Every proto API should have defined the urls - it is required by Try-it feature. Urls are defined in the `servers` section in the `gendocu_apispec.yaml`.
```yaml
servers:
  - selector: "*" # the * must be wrapped with ""
    envs:
    - name: "gcp" # the first environment is the default one
      urls:
      - grpcwebs://library-app-grpcweb-uqnits2f5q-uc.a.run.app
      - grpcs://library-app-grpc-uqnits2f5q-uc.a.run.app:443
    - name: "aws" # aws lambda doesn't support the grpc out of the box
      urls:
      - grpcwebs://t30z1m0w81.execute-api.us-east-1.amazonaws.com
```

### Servers

| Field | Required | Type | Description |
| -- | -- | -- | -- |
| selector | yes | glob-pattern | The glob pattern for the grpc services. It matches the whole service id - the package concatenated with the service name. The pattern `*.v1.PlanService` will match the `PlanService` defined in any package with suffix `.v1`. |
| envs | yes | list of environment description | Describes single environment for a selected by `selector` services. |

### Environment description

| Field | Required | Type | Description |
| -- | -- | -- | -- |
| name | yes | any-string | The unique identifier for the environment. You can define the environment with the same name for the different selectors - they will be matched together in the documentation. Service1 can have URL `some-url.com:443` in environment `prod`. In contrast, Service2 can have `some-other-url.com` in the same `prod` environment. |
| urls | no* | URL | All the URLs for a given selector. You can't define multiple URLs of the same type for a single environment. Read more in the section [Service URL description](/docs/documentation-setup/#service-url-description) |

\* recommended

### Service URL description

You can define service URLs for different technologies, including `grpc`, `grpc-web`, and `rest` (grpc-gateway). By adding `s` suffix, you define the SSL-protected channel. The try-it feature requires the `grpc` or `grpcs` to be defined. Allowed prefixes:
| Prefix | Example URL | Description |
| -- | -- | -- |
| grpcs | grpcs://library-app-grpc-uqnits2f5q-uc.a.run.app:443 | Standard gRPC url with SSL. It should contain port. |
| grpc | grpc://insecure-grpc.com:80 | Standard gRPC url for insecure connections. It should contain port. |
| grpcwebs | grpcweb://library-app-grpcweb-uqnits2f5q-uc.a.run.app | The grpc-web url over HTTPS (with SSL). The port is defaulted to 443. |
| grpcweb | grpcweb://insecure-grpcweb.com:80 | The grpc-web url over HTTP. |
| rests | rests://some-grpc-gateway-api.com:443 | The REST url for the gRPC API over HTTPS. |
| rest | rest://some-insecure-grpc-gateway-api.com:80 | The REST url for the gRPC API over HTTP. |

## Authentication schemes

GenDocu automatically generates the complete code snippets. To improve the user experience, we have also implemented the authentication schemes mechanism.
It is used for the 'Try it' feature and the code snippet generation. We support only call credentials. You can define them in `gendocu_apispec.yaml`:
```yaml
securitySchemes:
  - name: token-auth # <scheme-id>  
    title: Token authentication # <scheme-name>
    description: # <scheme-description>
      text: Token based authentication. You can create a personal token in account settings and use it with this method. Personal tokens do not expire.
    callAuthentication: # define it only if your auth method requires call authentication - can be skipped for public APIs
      token:
        exampleValue: "aaa.bbbbbbb.ccc" # a meaningful token used as a hint for user
        grpc: # can be skipped if auth method does not support grpc
          meta: "x-authorization" 
          valuePrefix: "bearer " # including whitespaces, the prefix for each value
        grpcweb: # can be skipped if auth method does not support grpc-web
          header: "authorization"
          valuePrefix: "Bearer " # including whitespaces, the prefix for each value
        rest: # can be skipped if auth method does not support rest (grpc-gateway)
           header: "Authorization"
           valuePrefix: "Bearer " # including whitespaces, the prefix for each value
```

The first method would be picked as default.

### Security Schemes

| Field | Required| Type | Description |
|--|--|--|--|
| name | yes | any string | The authentication scheme identifier. It must be unique across a single project.|
| title | yes | any string | The method name. It is visible in the generated documentation. |
| description | no | [Description object](/docs/documentation-setup/#description-object) | The authentication method description. It should describe the way of obtaining the credentials and their longevity.  |
| callAuthentication | no | [Call Authentication](/docs/documentation-setup/#call-authentication) | The per-call authentication scheme. |


### Description object
The object has two mutually exclusive fields: `text` and `file` - only one can be set.

| Field |  Type | Description |
| -- | -- | -- |
| text | string | Plain text description |
| file | file path | File path to the markdown file.|


### Call Authentication

This structure can have only one field - token. The token object should have set at least one of the fields `grpc`, `grpcweb` or `rest`. The try-it feature uses the `grpc` scheme for authentication.

| Field | Required | Type | Description |
|--|--|--|--|
| exampleValue | yes | any string | The example token value. It should be a meaningful example of a valid token. The token is shared across grpc, grpc-web, and grpc-gateway (REST) code snippets. |
| grpc | no* | [gRPC Token Authentication](/docs/documentation-setup/#grpc-token-authentication) | Describes the authentication for gRPC protocol. |
| grpcweb | no | [gRPC Web Token Authentication](/docs/documentation-setup/#grpc-web-token-authentication) | Describes the authentication for gRPC-Web protocol.  |
| rest | no | [REST Token Authentication](/docs/documentation-setup/#rest-token-authentication) | Describes the authentication for gRPC-gateway (REST) protocol.  |

\* recommended

### gRPC Token Authentication

| Field | Required | Type | Description |
| -- | -- | -- | -- |
| meta | yes | string | The gRPC's metadata name |
| valuePrefix | yes| string | The gRPC's metadata value. |

### gRPC Web Token Authentication

| Field | Required | Type | Description |
| -- | -- | -- | -- |
| header | yes | string | gRPC Web's HTTP header name |
| valuePrefix | yes| string | gRPC Web's HTTP header value |

### REST Token Authentication

| Field | Required | Type | Description |
| -- | -- | -- | -- |
| header | yes | string | HTTP header name |
| valuePrefix | yes| string | HTTP header value |

## gRPC Dependencies

GenDocu automatically bundles the type definition from `google.protobuf`.
To provide any additional dependency, you can add it as a git submodule. Then you have to add the dependency's protoc root to the project's protoc roots.
Please keep in mind that the dependencies affect the build time and the SDK size.


## What's next

We encourage you to read also the [documentation improvements](/docs/documentation-improvements/).