defmodule RentApi.Rent.ItemSpec do
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
      expect(Item.changeset(item(), %{owner_id: item.owner.id}).valid?) |> to(eq(true))
    end

    it "has valid price" do
      expect(Item.changeset(item(), %{daily_price_cents: -1}).valid?) |> to(eq(false))
    end

    it "has non empty name" do
      expect(Item.changeset(item(), %{name: ""}).valid?) |> to(eq(false))
    end
  end

  context "Scopes" do
    let! :city, do: insert(:city)
    let! :item_owner, do: insert(:user, city: city())
    let! :first_item, do: insert(:item, owner: item_owner())
    let! :second_item, do: insert(:item)

    it "filters by owner city" do
      expect(Item |> Item.by_city([city().id]) |> Repo.all() |> Enum.map(&(&1.id)))
      |> to(eq [first_item().id])
    end

    it "filters by users" do
      expect(Item |> Item.by_users([item_owner().id]) |> Repo.all() |> Enum.map(&(&1.id)))
      |> to(eq([first_item().id]))
    end
  end
end
