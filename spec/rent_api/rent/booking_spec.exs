defmodule RentApi.Rent.BookingSpec do
  use ESpec.Phoenix, model: Booking
  alias RentApi.Rent.Booking
  alias RentApi.Repo
  import RentApi.Factory

  context "Validation" do
    let :booking do
      build(:booking)
    end

    it "belongs to valid renter" do
      changeset = Booking.changeset(build(:booking, renter: nil), %{})
      expect(Repo.insert(changeset)) |> to(match_pattern{:error, _})
      expect(Booking.changeset(booking(), %{}).valid?) |> to(eq(true))
    end

    it "belongs to valid item" do
      changeset = Booking.changeset(build(:booking, item: nil), %{})
      expect(Repo.insert(changeset)) |> to(match_pattern{:error, _})
    end

    it "has valid price" do
      expect(Booking.changeset(booking(), %{cost_cents: -1}).valid?) |> to(eq(false))
    end

    it "has valid dates or nulls" do
      expect(Booking.changeset(booking(), %{start_date: nil}).valid?) |> to(eq(false))
      expect(Booking.changeset(booking(), %{end_date: nil}).valid?) |> to(eq(false))
      expect(Booking.changeset(booking(), %{end_date: Timex.now(), start_date: Timex.shift(Timex.now(), minutes: 3)}).valid?) |> to(eq(false))
    end
  end

  context "Scopes" do
    let! :first_item, do: insert(:item)
    let! :second_item, do: insert(:item)
    let! :first_renter, do: insert(:user)
    let! :second_renter, do: insert(:user)
    let! :first_booking, do: insert(:booking, item: first_item(), renter: first_renter())
    let! :second_booking, do: insert(:booking, item: second_item(), renter: second_renter())

    it "filters by items" do
      expect(Repo.all(Booking |> Booking.by_items([first_item().id]))
             |> Enum.map(&(&1.id)))
      |> to(eq [first_booking().id])
    end

    it "filters by renters" do
      expect(Repo.all(Booking |> Booking.by_renters([first_renter().id]))
             |> Enum.map(&(&1.id)))
      |> to(eq [first_booking().id])
    end

    it "filters by owners" do
      expect(Repo.all(
             Booking
             |> Booking.by_item_owners([first_item().owner.id])
             |> Booking.by_items([first_item().id]))
             |> Enum.map(&(&1.id)))
      |> to(eq [first_booking().id])
    end
  end
end
