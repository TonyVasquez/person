defmodule Person do
  @moduledoc """
    Api for manage Person
  """
  defstruct [:name, :surname, :age]

  @server Person.Server

  def start_link do
    GenServer.start_link(@server, %{}, name: @server)
  end

  @doc """
    Add new person

    ## Examples
    iex> Person.start_link
    iex> person = %Person{name: "Petya", surname: "Ivanov", age: 20}
    iex> Person.add(person)
    :ok
  """
  @spec add(Person.t()) :: :ok
  def add(%Person{} = person), do: GenServer.call(@server, {:add, person})

  @doc """
    Remove person

    ## Examples
    iex> person = %Person{name: "Petya", surname: "Ivanov", age: 20}
    iex> Person.remove(person)
    :ok
  """
  @spec remove(Person.t()) :: :ok | :not_found
  def remove(%Person{} = person) do
    GenServer.call(@server, {:remove, person})
  end

  @spec status :: {:status, pid, {:module, atom}, [any]}
  def status, do: :sys.get_status(@server)
end
