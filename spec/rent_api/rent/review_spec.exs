defmodule RentApi.Account.ReviewSpec do
  use ESpec.Phoenix, model: Review
  alias RentApi.Rent.Review
  alias RentApi.Repo
  alias RentApi.Account.User
  import RentApi.Factory

  context "Validation" do
    let :review do
      build(:review)
    end

    it "has non empty description" do
      expect(Review.changeset(review(), %{description: ""}).valid?) |> to(eq(false))
    end

    it "has only one reviewable" do
      changeset = Review.changeset(build(:review, user: build(:user), item: build(:item)), %{})
      expect(changeset.valid?) |> to(eq(false))
      expect(changeset.errors) |> to(have reviewable: {"can't review more than one object", []})
      # IO.inspect(changeset)
    end
  end
end
