ESpec.configure fn(config) ->
  config.before fn(tags) ->
    {:shared, hello: :world, tags: tags}
  end

  config.finally fn(_shared) ->
    :ok
  end
end
Code.require_file("spec/phoenix_helper.exs")
:ok = Ecto.Adapters.SQL.Sandbox.checkout(RentApi.Repo)
{:ok, _} = Application.ensure_all_started(:ex_machina)
Faker.start()
