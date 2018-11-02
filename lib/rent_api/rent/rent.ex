defmodule RentApi.Rent do
  alias RentApi.Rent.Item
  alias RentApi.Rent.City
  alias RentApi.Rent.Review
  alias RentApi.Rent.Booking
  alias RentApi.Repo

  def create_item(params, owner) do
    Ecto.build_assoc(owner, :items, params)
      |> Item.changeset(params)
      |> Repo.insert()
  end

  def delete_item(item = %Item{}) do
    Repo.delete(item)
  end

  def update_item(item = %Item{}, params) do
    item
    |> Item.changeset(params)
    |> Repo.update()
  end

  def new_item do
    Item.changeset(%Item{}, %{})
  end

  def get_item(id) do
    Repo.get(Item, id) || %Item{}
  end

  def create_city(params) do
    City.changeset(%City{}, params)
    |> Repo.insert()
  end

  def delete_city(city = %City{}) do
    Repo.delete(city)
  end

  def update_city(city = %City{}, params) do
    city
    |> City.changeset(params)
    |> Repo.update()
  end

  def new_city do
    City.changeset(%City{}, %{})
  end

  def get_city(id) do
    Repo.get(City, id) || %City{}
  end

  def create_review(params, author, reviewable) do
    Ecto.build_assoc(reviewable, :reviews, params)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:author, author)
      |> Review.changeset(params)
      |> Repo.insert()
  end

  def delete_review(review = %Review{}) do
    Repo.delete(review)
  end

  def update_review(review = %Review{}, params) do
    review
    |> Repo.preload([:user, :item])
    |> Review.changeset(params)
    |> Repo.update()
  end

  def new_review do
    Review.changeset(%Review{}, %{})
  end

  def get_review(id) do
    Repo.get(Review, id) || %Review{}
  end

  def create_booking(params, renter, item) do
    Ecto.build_assoc(item, :bookings, params)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:renter, renter)
      |> Booking.changeset(params)
      |> Repo.insert()
  end

  def delete_booking(booking = %Booking{}) do
    Repo.delete(booking)
  end

  def update_booking(booking = %Booking{}, params) do
    booking
    |> Booking.changeset(params)
    |> Repo.update()
  end

  def new_booking do
    Booking.changeset(%Booking{}, %{})
  end

  def get_booking(id) do
    Repo.get(Booking, id) || %Booking{}
  end
end
