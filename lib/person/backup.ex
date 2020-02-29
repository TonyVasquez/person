defmodule Person.Backup do
  @moduledoc """
    Backup can save Person.Server's state if it terminated and
     recovery state after restart main server
  """
  use GenServer
  @me __MODULE__

  def start_link(_opts) do
    GenServer.start_link(@me, %{}, name: @me)
  end

  ## API
  def run(state), do: GenServer.cast(@me, {:backup, state})

  def recover, do: GenServer.call(@me, :recover)

  ## Server

  @spec init(any) :: {:ok, any}
  def init(args), do: {:ok, args}

  def handle_cast({:backup, state}, _state) do
    {:noreply, state}
  end

  def handle_call(:recover, _from, state) do
    {:reply, state, %{}}
  end
end
