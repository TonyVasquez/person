%{
  configs: [
    %{
      name: "default",
      checks: [
        #checks were skipped because they're not compatible with
        #version of Elixir (1.9.1)

        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Warning.LazyLogging, false}
      ]
    }
  ]
}
