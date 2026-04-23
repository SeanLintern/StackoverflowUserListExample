# StackOverflowUserListExample.

## Overview

This codebase produces an example app that shows the top 20 users of StackOverflow in descending order by reputation.

There is the ability to "Follow" these users via a local service that stores the followed users across sessions and then 
restores them on load.

User are displayed with their profile image, name and reputation count as well as their followed status.

## Architecture

This codebase is written using Swift 6 using Swift strict concurrency, and utilises an MVVM approach to views and data in attempt 
to obfuscate business logic from the underlying views. Services are built on app load and injected down into the only current
screen, there is an argument for a dependency graph manager of some kind or a better way to manage dependencies to reduce boiler 
plate if more screens where added. The codebase is split down into several sub-modules for easier management and seperation of concerns.

## Running

The app should run straight away without any external dependencies, as well as the previews for the view controller.

## Modules

The app is broken down into:

**StackOverflowUserListExample** - The main app target and screens

**Networking** - Netowrking layer for connecting to external data

**ImageService** - Allows retrieving images externally and soe convenience for previews, as well as an image caching service
which caches images when retreived and returns them on subsequent requests

**FollowService** - Local follower storage, allows cross session following

**UserService** - Service to specifically handle retrieving user data.

Some of the modules are interdependent which could be mostly improved by removing the `Client` from `Netowkring` and making an
extension on URLSession in some way to inject that into the requiring modules.

##Testing

All service modules should have underlying tests for the implementations
