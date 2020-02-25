defmodule Person.Server do
  @moduledoc """
    Server for manage persons
  """
  use GenServer

  alias Person.Impl

  @spec init(any) :: {:ok, any}
  def init(args) do
    {:ok, args}
  end

  def handle_call({:add, %Person{} = person}, _from, state) do
    {:reply, :ok, Impl.add(person, state)}
  end

  def handle_call({:remove, %Person{} = person}, _from, state) do
    {res, new_state} = Impl.remove(person, state)
    {:reply, res, new_state}
  end
end
