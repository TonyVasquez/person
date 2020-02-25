defmodule PersonTest do
  use ExUnit.Case
  doctest Person

  describe "add person to db" do
    test "added successfully" do
      person = %Person{name: "Petya", surname: "Ivanov", age: 20}
      assert :ok == Person.add(person)
    end
  end

  describe "remove person from db" do
    test "removed successfuly" do
      person = %Person{name: "Petya", surname: "Ivanov", age: 20}
      assert :ok == Person.remove(person)
    end
  end
end
