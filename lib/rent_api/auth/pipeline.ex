defmodule RentApi.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :rent_api,
    module: RentApi.Auth.Guardian,
    error_handler: RentApi.Auth.ErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end
