defmodule PersonFaultToleranceTest do
  use ExUnit.Case

  describe "when Person.Server died" do
    @tag capture_log: true
    test "fetch persons" do
      person = %Person{name: "Petya", surname: "Ivanov", age: 20}
      Person.add(person)

      server = Process.whereis(Person.Server)

      GenServer.cast(server, :kill)
      # whait for supervisor restart server
      Process.sleep(100)

      assert person in Person.find_by_age(person.age)
    end
  end
end
