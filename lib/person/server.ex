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

  def handle_call({:age_of, person_name}, _from, state) do
    {:reply, Impl.age_of(person_name, state), state}
  end

  def handle_call({:find_by_age, age}, _from, state) do
    {:reply, Impl.find_by_age(age, state), state}
  end

  def handle_call(:reset_state, _from, _state) do
    {:reply, :ok, %{}}
  end
end
