Code.ensure_loaded?(Hex) and Hex.start

defmodule Savory.Mixfile do
  use Mix.Project

  def project do
    [app: :savory,
     version: "0.0.2",
     elixir: "elixir: "~> 0.15.1 or ~> 1.0.0",
     deps: deps,
     aliases: aliases,
     description: description,
     package: package,
     docs: [readme: true, main: "README"]
     ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger],
     mod: {Savory.App, []}]
  end

  defp aliases do
    [compile: ["compile", &run_make/1]]
  end

  defp run_make(_) do
    IO.puts "Compiling salt_nif.c"
    if Mix.shell.cmd("make") != 0 do
      raise Mix.Error, message: "error running make"
    end
  end

  defp description do
    """
    An Elixir implementation of Freza's salt_nif which interfaces with libsodium, 
    a wrapper for the cryptographic primitive libary NaCl.
    """
  end

  defp package do
    [
      files: ["config", "src", "lib", "mix.exs", "Makefile", "README*"],
      contributers: ["ElectricFeel", "Freza"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/electricFeel/savory"} 
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end
end
