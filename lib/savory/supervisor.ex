defmodule Savory.Supervisor do
	use Supervisor

	def start_link, do: Supervisor.start_link(__MODULE__, :ok)

	def init(:ok) do
		IO.puts "starting supervisor"
		children = [
			worker(Savory.Server, [])
		]
		supervise(children, strategy: :one_for_one)
	end
end