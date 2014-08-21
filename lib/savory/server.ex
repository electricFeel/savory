defmodule Savory.Server do
  use GenServer
  alias Savory.Config, as: C
  alias Savory.SavoryNif, as: Nif
  alias Savory.Server, as: Server
  
  defstruct pcb: nil

  def start_link() do
  	IO.puts "starting server"
    GenServer.start_link(__MODULE__, [], name: :savory_server)
  end

  #API

  def make_random_bytes(n) do
    case GenServer.call(:savory_server, {:make_random_bytes, n}) do
      {:ok, bytes} -> bytes
      {:error, rsn} -> exit({:savory, :random_bytes, rsn})
    end
  end

  def make_box_keypair() do
    case GenServer.call(:savory_server, {:make_box_keypair}) do
      {:ok, pk_sk} -> pk_sk
      {:error, rsn} -> exit({:savory, :make_box_keypair, rsn})
    end
  end

  def make_sign_keypair() do
    case GenServer.call(:savory_server, {:make_sign_keypair}) do
      {:ok, pk_sk} -> pk_sk
      {:error, rsn} -> exit({:savory, :make_sign_keypair, rsn})
    end
  end

  #Callbacks

  def init([]) do
    ok = Nif.load()
    pcb = Nif.start()
    {ok, %Server{pcb: pcb}}
  end

  def handle_call({:make_random_bytes, n}, {pid, mref}, state) do
    try do
     case Nif.salt_random_bytes(state.pcb, pid, mref, n) do
       :enqueued -> {:noreply, state}
       error -> {:reply, {:error, error}, state}
     end
    catch
      error: :badarg ->
            {:reply, {:error, :badarg}, state}
   end
  end

  def handle_call({:make_box_keypair}, {pid, mref}, state) do
    try do
     case Nif.salt_box_keypair(state.pcb, pid, mref) do
       :enqueued -> {:noreply, state}
       error -> {:reply, {:error, error}, state}
     end
    catch
      error: :badarg ->
            {:reply, {:error, :badarg}, state}
   end
  end

  def handle_call({:make_sign_keypair}, {pid, mref}, state) do
    try do
     case Nif.salt_sign_keypair(state.pcb, pid, mref) do
       :enqueued -> {:noreply, state}
       error -> {:reply, {:error, error}, state}
     end
    catch
      error: :badarg ->
            {:reply, {:error, :badarg}, state}
   end
  end

  def handle_call(_, _, state) do
    {:reply, {:error, :bad_request}, state}
  end

  def handle_cast(_, state), do: {:noreply, state}

  def handle_info(_, state), do: {:noreply, state}

  def code_change(_, state, _), do: {:ok, state}

  def terminate(_, _), do: {:ok}
end