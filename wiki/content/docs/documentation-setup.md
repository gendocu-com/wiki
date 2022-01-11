---
date: 9.11.2021
title: Project setup
weight: 10
next: /docs/documentation-improvements
---
# Project Setup

Project is a central entity - it contains some source API, related SDK repository, and documentation page.
Creating a project is the first thing you have to do to use our platform.

## The project creation

The project creation process consists of 3 steps. All the newly created projects have an assigned free plan - you can change it after the project creation.

### gRPC Source

To create documentation with SDK, you have to select the gRPC source repository. GenDocu accepts only git repositories.
You can select the repository from:

1. Any GitHub repository - is the preferred way of serving the proto definitions. GenDocu can create a webhook to rebuild the SDK automatically.
2. Any public Git repository, e.g., from Gitlab, BitBucket, AWSCommit. Must manually trigger any change.

After selecting the repository, you have to choose Proto Roots.
Proto Root is the main directory relative to the repository root used to determine the includes between proto files.
For the [demo repository](https://github.com/gendocu-com-examples/library-app), the proto root is `/proto` directory.
You can also select multiple proto root directories - it is useful for serving the dependencies.

### SDK destination

GenDocu automatically generates the SDK for your gRPC API. It stores the libraries in the git repository - each build has a related commit in the SDK repository.
There are three possible SDK destinations:
1. GenDocu Public Git Repository - recommended for public projects. GenDocu serves the whole SDK from git.gendocu.com. The SDK will be public.
2. Existing GitHub repository - GenDocu overwrites the `sdk` directory in the root repository. We always commit to the master branch - the best for private projects.
3. New GitHub repository - we will create a repository in a selected organization with a selected name. The repository will be created as private - you might change it manually later.
   GenDocu does not support creating a repository within the personal Github space - you have to create a repository manually.

You can also use the gRPC source repository as SDK destination repository - GenDocu will overwrite only the `sdk` directory.

### General Settings

In the last step, you have to select the project name. You can't change the name later.
It will be used as the unique identifier for your project among your organization.

Documentation visibility has two settings:

1. Public - everyone can read the project's documentation. Anonymous user has a `read-only` role.
2. Private - users have to authenticate to read the project's documentation. You can create a password for the documentation or add the user with the role `read-only`

You can read more about the roles [here](/docs/managing-users/#role-based-access).

## What's next

We encourage you to read also the [providing gRPC API information](/docs/providing-grpc-api-information/).