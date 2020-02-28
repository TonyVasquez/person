defmodule PersonTest do
  use ExUnit.Case, async: true
  doctest Person

  setup_all do
    Person.start_link()
    :ok
  end

  setup do
    GenServer.call(Person.Server, :reset_state)
    person = %Person{name: "Petya", surname: "Ivanov", age: 20}

    group = [
      %Person{name: "Petya", surname: "Ivanov", age: 20},
      %Person{name: "Alex", surname: "Ruf", age: 20},
      %Person{name: "Bob", surname: "Jin", age: 25}
    ]

    [person: person, group: group]
  end

  describe "add person to db" do
    test "added successfully", context do
      assert :ok == Person.add(context.person)
    end

    test "async add", context do
      Enum.each(context.group, fn person ->
        spawn(fn -> Person.add(person) end)
      end)

      Process.sleep(100)

      group_20 = Person.find_by_age(20) |> Enum.map(& &1.name)
      group_25 = Person.find_by_age(25) |> Enum.map(& &1.name)

      assert "Petya" in group_20
      assert "Alex" in group_20
      assert "Bob" in group_25
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
    test "when persons founded", context do
      Enum.each(context.group, &Person.add/1)

      founded_persons_name = Person.find_by_age(20) |> Enum.map(& &1.name) |> Enum.sort()
      assert founded_persons_name == ["Alex", "Petya"]
    end

    test "when persons not found" do
      assert Person.find_by_age(20) == []
    end
  end
end
