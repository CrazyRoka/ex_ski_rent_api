defmodule RentApi.RentSpec do
  use ESpec.Phoenix, model: Rent
  alias RentApi.Rent.Item
  alias RentApi.Rent.Booking
  alias RentApi.Rent.City
  alias RentApi.Rent.Review
  alias RentApi.Rent
  alias RentApi.Repo
  import RentApi.Factory

  context "Item" do
    let :item do
      build(:item)
    end

    it "creates item" do
      expect(fn -> Rent.create_item(Map.merge(Map.from_struct(item()), %{owner_id: item.owner.id})) end)
      |> to(change fn -> Repo.aggregate(Item, :count, :id) end, by: 1)
    end

    it "updates item" do
      {:ok, item} = Repo.insert(item())
      expect(fn -> Rent.update_item(item, %{name: "Test"}) end)
      |> to(change fn -> Repo.get(Item, item.id).name end)
    end

    it "deletes item" do
      {:ok, item} = Repo.insert(item())
      expect(fn -> Rent.delete_item(item) end)
      |> to(change fn -> Repo.aggregate(Item, :count, :id) end, by: -1)
    end

    it "builds item" do
      expect(Rent.new_item()) |> to(eq(Item.changeset(%Item{}, %{})))
    end

    it "gets item" do
      {:ok, item} = Repo.insert(item())
      expect(Rent.get_item(item.id).id) |> to(eq item.id)
    end
  end
end
