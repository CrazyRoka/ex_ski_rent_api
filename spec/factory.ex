 defmodule RentApi.Factory do
   use ExMachina.Ecto, repo: RentApi.Repo
   alias RentApi.Account.User
   alias RentApi.Rent.Item
   alias RentApi.Rent.Booking
   alias RentApi.Rent.Review
   alias RentApi.Rent.City
   use Timex

   def user_factory do
     %User{
       name: Faker.Name.name(),
       password: "12345678",
       email: Faker.Internet.email(),
       balance: 1234
     }
   end

   def item_factory do
     %Item{
       daily_price_cents: 1234,
       name: Faker.Name.first_name(),
       owner: build(:user)
     }
   end

   def booking_factory do
     %Booking{
       cost_cents: 1234,
       start_date: Timex.shift(Timex.now, minutes: 3),
       end_date: Timex.shift(Timex.now, minutes: 10),
       item: build(:item),
       renter: build(:user)
     }
   end

   def review_factory do
     %Review{
       author: build(:user),
       description: "some comment",
     }
   end

   def user_review_factory do
     %Review{
       author: build(:user),
       description: "some comment",
       user: build(:user)
     }
   end

   def city_factory do
     %City{
       name: Faker.Address.city()
     }
   end
 end
