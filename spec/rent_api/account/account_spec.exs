defmodule RentApi.AccountSpec do
  use ESpec.Phoenix, model: Account
  alias RentApi.Account.User
  alias RentApi.Account
  alias RentApi.Repo
  import RentApi.Factory

  context "User" do
    let :user do
      build(:user)
    end

    it "creates user" do
      expect(fn -> Account.create_user(Map.from_struct(user())) end)
      |> to(change fn -> Repo.aggregate(User, :count, :id) end, by: 1)
    end

    it "updates user" do
      {:ok, user} = Repo.insert(user())
      expect(fn -> Account.update_user(user, %{name: "Test"}) end)
      |> to(change fn -> Repo.get(User, user.id).name end)
    end

    it "deletes user" do
      {:ok, user} = Repo.insert(user())
      expect(fn -> Account.delete_user(user) end)
      |> to(change fn -> Repo.aggregate(User, :count, :id) end, by: -1)
    end

    it "builds user" do
      expect(Account.new_user()) |> to(eq(User.changeset(%User{}, %{})))
    end
  end
end
