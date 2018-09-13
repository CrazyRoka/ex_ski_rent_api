defmodule RentApi.Account.ReviewSpec do
  use ESpec.Phoenix, model: Review
  alias RentApi.Rent.Review
  import RentApi.Factory

  context "Validation" do
    let :review do
      build(:user_review)
    end

    it "has non empty description" do
      expect(Review.changeset(review(), %{description: ""}).valid?) |> to(eq(false))
    end

    it "has only one reviewable" do
      changeset = Review.changeset(build(:review, user: build(:user), item: build(:item)), %{})
      expect(changeset.valid?) |> to(eq(false))
      expect(changeset.errors) |> to(have reviewable: {"can't review more than one object", []})
    end

    it "must have bookings before review" do
      booking = insert(:booking)
      review = build(:review, item: booking.item)

      expect(Review.changeset(review, %{}).valid?) |> to(eq(false))

      review = build(:review, item: booking.item, author: booking.renter)
      expect(Review.changeset(review, %{}).valid?) |> to(eq(true))
    end
  end
end
