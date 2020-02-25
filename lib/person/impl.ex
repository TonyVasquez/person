defmodule Person.Impl do
  @moduledoc """
    Contains business logic for manage persons
  """
  @spec add(Person.t(), map) :: map
  def add(%Person{name: name, surname: surname} = person, state) do
    Map.update(state, "#{name} #{surname}", person, & &1)
  end

  @spec remove(Person.t(), map) :: {:not_found, map} | {:ok, map}
  def remove(%Person{name: name, surname: surname} = _person, state) do
    key = "#{name} #{surname}"

    case Map.get(state, key) do
      %Person{} -> {:ok, Map.delete(state, key)}
      _ -> {:not_found, state}
    end
  end
end
