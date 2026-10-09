defmodule JaResource.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ja_resource,
      version: "0.3.2",
      elixir: "~> 1.15",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/vt-elixir/ja_resource",
      package: package(),
      description: description(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  def application do
    extra_applications = if Mix.env() == :test, do: [:poison], else: []
    [applications: [:ecto, :logger, :phoenix] ++ extra_applications]
  end

  defp deps() do
    [
      # Flow is limiting this to 0.1.22
      {:castore, ">= 0.1.22"},
      # Flow is limiting this to 2.14.2
      {:cowboy, "~> 2.14.2"},
      # RTA is limiting this to 2.17.1
      {:cowlib, "~> 2.17.1"},
      # RTA is limiting this to 2.3.0
      {:decimal, ">= 2.3.0"},
      # Flow is limiting this to 3.7.2
      {:ecto, ">= 3.7.2"},
      {:ja_serializer, "~> 0.18"},
      # All our apps are currently on 1.6.16
      {:phoenix, "~> 1.6.16"},
      # All our apps are currently on 2.1.3
      {:phoenix_pubsub, "~> 2.1.3"},
      # All our apps are currently on 1.0.4
      {:phoenix_template, "~> 1.0.4"},
      {:plug, "~> 1.17.0"},
      # Flow is limiting this to 2.6.2
      {:plug_cowboy, ">= 2.6.2"},
      {:poison, "~> 3.1"},
      # All of our apps are currently on 2.2.0
      {:ranch, "~> 2.2.0"},
      {:sobelow, "~> 0.16", only: [:dev, :test], runtime: false, warn_if_outdated: true},
      # Flow is limiting this to 1.0.0
      {:telemetry, ">= 1.0.0"}
    ]
  end

  defp package() do
    [
      licenses: ["Apache 2.0"],
      maintainers: ["Alan Peabody", "Pete Brown"],
      links: %{
        "GitHub" => "https://github.com/vt-elixir/ja_resource"
      }
    ]
  end

  defp description do
    """
    A behaviour for defining JSON-API spec controllers in Phoenix.

    Lets you focus on your data, not on boilerplate controller code. Like Webmachine for Phoenix.
    """
  end
end
