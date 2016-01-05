# JaResource

A behaviour for defining JSON-API spec controllers in Phoenix.

Lets you focus on your data, not on boilerplate controller code. Provides
complete ability to customize everything, while removing the boilerplate.


** DISCLAIMER: This is curretly pre-release software **

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add ja_resource to your list of dependencies in `mix.exs`:

        def deps do
          [{:ja_resource, "~> 0.0.1"}]
        end

  2. Ensure ja_resource is started before your application:

        def application do
          [applications: [:ja_resource]]
        end