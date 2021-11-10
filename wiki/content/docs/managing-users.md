---
date: 02.08.2021
title: Managing the users
weight: 12
---

# Managing the users

GenDocu supports creating two types of projects - private and public. The documentation and SDK in public projects are available for everyone.
GenDocu does not sync the user roles with any repository - including the SDK and gRPC source repository.

## Role-based access
Every project has its role list. The project creator gets the `owner` role.  Every project has to have at least one `owner`.

| Permission | (no role) | Read-only | Developer | Owner |
|---|---|---|---|---|
| Read public project documentation (newest) | ✅ |✅ |✅ |✅ |
| Read private project documentation (newest) | ❌ | ✅ | ✅ |✅ |
| Read public project build documentation (all) | ❌ |  ❌ | ✅ |✅ |
| Read private project build documentation (all) | ❌ | ❌ | ✅ |✅ |
| Can read, edit, delete the project in the GenDocu Console  | ❌ | ❌ | ✅ |✅ |
| Can grant, change permissions  | ❌ | ❌ | ❌ |✅ |



## Password protection

Among the existing role system, you can create a password for the documentation.
It is the preferred solution for the embeddable GenDocu widget.

User authenticated with password has a `read-only` role and cannot read/edit the project in the GenDocu Console.

## Password authenticated users

Private project's anonymous user (authenticated with project's password) gets a `read-only` role. 

