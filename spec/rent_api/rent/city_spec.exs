defmodule RentApi.Account.CitySpec do
  use ESpec.Phoenix, model: Review
  alias RentApi.Rent.City
  import RentApi.Factory

  context "Validation" do
    let :city do
      build(:city)
    end

    it "has non empty name" do
      expect(City.changeset(city(), %{name: ""}).valid?) |> to(eq(false))
    end
  end
end
