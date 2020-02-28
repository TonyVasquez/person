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

  @spec age_of(binary, map) :: integer
  def age_of(person_name, state) do
    case state[person_name] do
      %Person{age: age} -> age
      _ -> :not_found
    end
  end

  @spec find_by_age(integer, map) :: [Person.t()]
  def find_by_age(age, state) do
    Enum.reduce(state, [], fn {_name, person}, acc ->
      if person.age == age do
        [person | acc]
      else
        acc
      end
    end)
  end
end
