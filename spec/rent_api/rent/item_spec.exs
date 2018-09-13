defmodule RentApi.Account.ItemSpec do
  use ESpec.Phoenix, model: Item
  alias RentApi.Rent.Item
  alias RentApi.Repo
  import RentApi.Factory

  context "Validation" do
    let :item do
      build(:item)
    end

    it "belongs to valid owner" do
      changeset = Item.changeset(build(:item, owner: nil), %{})
      expect(Repo.insert(changeset)) |> to(match_pattern{:error, _})
      expect(Item.changeset(item(), %{}).valid?) |> to(eq(true))
    end

    it "has valid price" do
      expect(Item.changeset(item(), %{daily_price_cents: -1}).valid?) |> to(eq(false))
    end

    it "has non empty name" do
      expect(Item.changeset(item(), %{name: ""}).valid?) |> to(eq(false))
    end
  end
end
