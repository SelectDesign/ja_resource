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
      {:ecto, "~> 3.7"},
      {:plug, "~> 1.17.0"},
      {:plug_cowboy, "~> 2.6"},
      {:phoenix, "~> 1.4"},
      {:ja_serializer, "~> 0.18"},
      {:poison, "~> 3.1"},
      {:sobelow, "~> 0.15", only: [:dev, :test], runtime: false, warn_if_outdated: true}
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
