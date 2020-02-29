defmodule Person.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      Person.Backup,
      Person.Server
    ]

    opts = [strategy: :rest_for_one, name: Person.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
