defmodule RentApi.Account.ItemSpec do
  use ESpec.Phoenix, model: Review
  alias RentApi.Rent.Review
  alias RentApi.Repo
  import RentApi.Factory

  context "Validation" do
    let :review do
      build(:review)
    end

    it "belongs to valid author" do
      changeset = Review.changeset(review, %{author: nil})
      expect(Repo.insert(changeset)) |> to(match_pattern{:error, _})
      expect(Review.changeset(review, %{}).valid?) |> to(eq(true))
    end

    it "has non empty description" do
      expect(Review.changeset(review, %{description: ""}).valid?) |> to(eq(false))
    end
  end
end
