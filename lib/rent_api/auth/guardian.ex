defmodule RentApi.Auth.Guardian do
  use Guardian, otp_app: :rent_api

  def subject_for_token(resource, _claim) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def subject_from_claims(claims) do
    case RentApi.Accounts.get_user(claims["sub"]) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
