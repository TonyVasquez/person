defmodule Person do
  @moduledoc """
    Api for manage Person
  """
  defstruct [:name, :surname, :age]

  @server Person.Server

  @doc """
    Add new person

    ## Examples
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
    iex> Person.add(person)
    iex> Person.remove(person)
    :ok
  """
  @spec remove(Person.t()) :: :ok | :not_found
  def remove(%Person{} = person) do
    GenServer.call(@server, {:remove, person})
  end

  @doc """
    Get age of person by name and surname

    ## Examples
    iex> person = %Person{name: "Petya", surname: "Ivanov", age: 20}
    iex> Person.add(person)
    iex> Person.age_of("Petya Ivanov")
    20
  """
  def age_of(person_name) when is_binary(person_name) do
    GenServer.call(@server, {:age_of, person_name})
  end

  @doc """
    Find persons by age

    ##Example
    iex> Person.add(%Person{name: "Petya", surname: "Ivanov", age: 20})
    iex> Person.add(%Person{name: "Bob", surname: "Jin", age: 20})
    iex> Person.find_by_age(20)
    [
      %Person{name: "Petya", surname: "Ivanov", age: 20},
      %Person{name: "Bob", surname: "Jin", age: 20}
    ]
  """
  @spec find_by_age(integer) :: [Person.t()]
  def find_by_age(age) when is_integer(age) do
    GenServer.call(@server, {:find_by_age, age})
  end

  @spec status :: {:status, pid, {:module, atom}, [any]}
  def status, do: :sys.get_status(@server)
end
