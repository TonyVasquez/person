defmodule PersonTest do
  use ExUnit.Case
  doctest Person

  setup_all do
    Person.start_link()
    :ok
  end

  setup do
    GenServer.call(Person.Server, :reset_state)
    person = %Person{name: "Petya", surname: "Ivanov", age: 20}
    [person: person]
  end

  describe "add person to db" do
    test "added successfully", context do
      assert :ok == Person.add(context.person)
    end
  end

  describe "remove person from db" do
    test "removed successfuly", context do
      Person.add(context.person)
      assert :ok == Person.remove(context.person)
    end

    test "when person not founded" do
      unknown_person = %Person{name: "John", surname: "Doe", age: 20}
      assert :not_found == Person.remove(unknown_person)
    end
  end

  describe "select age of person by full name" do
    test "when person exists", context do
      name = "#{context.person.name} #{context.person.surname}"
      Person.add(context.person)
      assert 20 == Person.age_of(name)
    end
  end

  describe "find by age" do
    test "when persons founded" do
      [
        %Person{name: "Petya", surname: "Ivanov", age: 20},
        %Person{name: "Alex", surname: "Ruf", age: 20},
        %Person{name: "Bob", surname: "Jin", age: 25}
      ]
      |> Enum.each(&Person.add/1)

      founded_persons_name = Person.find_by_age(20) |> Enum.map(& &1.name) |> Enum.sort()
      assert founded_persons_name == ["Alex", "Petya"]
    end
  end
end
