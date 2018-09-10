 defmodule RentApi.Factory do
   use ExMachina.Ecto, repo: RentApi.Repo

   def user_factory do
     %RentApi.Account.User{
       name: "Rostyslav Toch",
       password: "12345678",
       email: "roka@email.com",
       balance: 1234
     }
   end
 end
