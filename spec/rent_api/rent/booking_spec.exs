defmodule RentApi.Account.BookingSpec do
  use ESpec.Phoenix, model: Booking
  alias RentApi.Rent.Booking
  alias RentApi.Repo
  import RentApi.Factory

  context "Validation" do
    let :booking do
      build(:booking)
    end

    it "belongs to valid renter" do
      changeset = Booking.changeset(booking(), %{renter: nil})
      expect(Repo.insert(changeset)) |> to(match_pattern{:error, _})
      expect(Booking.changeset(booking(), %{}).valid?) |> to(eq(true))
    end

    it "belongs to valid item" do
      changeset = Booking.changeset(booking(), %{item: nil})
      expect(Repo.insert(changeset)) |> to(match_pattern{:error, _})
      expect(Booking.changeset(booking(), %{}).valid?) |> to(eq(true))
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
end
