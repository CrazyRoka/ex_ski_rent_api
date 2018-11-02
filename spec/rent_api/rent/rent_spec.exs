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
      build(:item, owner: insert(:user))
    end

    it "creates item" do
      expect(fn -> Rent.create_item(Map.from_struct(item), item.owner) end)
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

  context "City" do
    let :city do
      build(:city)
    end

    it "creates city" do
      expect(fn -> Rent.create_city(Map.from_struct(city())) end)
      |> to(change fn -> Repo.aggregate(City, :count, :id) end, by: 1)
    end

    it "updates city" do
      {:ok, city} = Repo.insert(city())
      expect(fn -> Rent.update_city(city, %{name: "Test"}) end)
      |> to(change fn -> Repo.get(City, city.id).name end)
    end

    it "deletes city" do
      {:ok, city} = Repo.insert(city())
      expect(fn -> Rent.delete_city(city) end)
      |> to(change fn -> Repo.aggregate(City, :count, :id) end, by: -1)
    end

    it "builds city" do
      expect(Rent.new_city()) |> to(eq(City.changeset(%City{}, %{})))
    end

    it "gets city" do
      {:ok, city} = Repo.insert(city())
      expect(Rent.get_city(city.id).id) |> to(eq city.id)
    end
  end

  context "Review" do
    let :review do
      build(:review)
    end

    it "creates review" do
      expect(fn -> Rent.create_review(Map.from_struct(review()), review.author, review.item) end)
      |> to(change fn -> Repo.aggregate(Review, :count, :id) end, by: 1)
    end

    it "updates review" do
      {:ok, review} = Repo.insert(review())
      expect(fn -> Rent.update_review(review, %{description: "Test"}) end)
      |> to(change fn -> Repo.get(Review, review.id).description end)
    end

    it "deletes review" do
      {:ok, review} = Repo.insert(review())
      expect(fn -> Rent.delete_review(review) end)
      |> to(change fn -> Repo.aggregate(Review, :count, :id) end, by: -1)
    end

    it "builds review" do
      expect(Rent.new_review()) |> to(eq(Review.changeset(%Review{}, %{})))
    end

    it "gets review" do
      {:ok, review} = Repo.insert(review())
      expect(Rent.get_review(review.id).id) |> to(eq review.id)
    end
  end

  context "Booking" do
    let :booking do
      build(:booking)
    end

    it "creates booking" do
      expect(fn -> Rent.create_booking(Map.from_struct(booking), booking.renter, booking.item) end)
      |> to(change fn -> Repo.aggregate(Booking, :count, :id) end, by: 1)
    end

    it "updates booking" do
      {:ok, booking} = Repo.insert(booking())
      expect(fn -> Rent.update_booking(booking, %{cost_cents: 4321}) end)
      |> to(change fn -> Repo.get(Booking, booking.id).cost_cents end)
    end

    it "deletes booking" do
      {:ok, booking} = Repo.insert(booking())
      expect(fn -> Rent.delete_booking(booking) end)
      |> to(change fn -> Repo.aggregate(Booking, :count, :id) end, by: -1)
    end

    it "builds booking" do
      expect(Rent.new_booking()) |> to(eq(Booking.changeset(%Booking{}, %{})))
    end

    it "gets booking" do
      {:ok, booking} = Repo.insert(booking())
      expect(Rent.get_booking(booking.id).id) |> to(eq booking.id)
    end
  end
end
