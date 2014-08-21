defmodule Savory.App do
	use Application

	def start(_type, _args) do
		Savory.Supervisor.start_link()
	end
end