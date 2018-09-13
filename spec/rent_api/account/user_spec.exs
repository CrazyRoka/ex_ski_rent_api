defmodule RentApi.Account.UserSpec do
  use ESpec.Phoenix, model: User
  alias RentApi.Account.User
  alias RentApi.Repo
  import RentApi.Factory

  context "Validation" do
    let :user do
      build(:user)
    end

    it "has long password" do
      changeset = User.changeset(user(), %{password: "1234567"})
      expect(changeset.valid?) |> to(eq(false))
    end

    it "has valid balance" do
      changeset = User.changeset(user(), %{balance: -1})
      expect(changeset.valid?) |> to(eq(false))
    end

    it "has unique email" do
      Repo.insert(user())
      changeset = User.changeset(user(), %{email: user().email})
      expect(Repo.insert(changeset)) |> to(match_pattern {:error, _})
    end
  end
end
