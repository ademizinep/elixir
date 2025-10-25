defmodule BananaBankWeb.Token do
  alias Phoenix.Token
  alias BananaBankWeb.Endpoint

  @sign_salt "user auth"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token, max_age: 86400)
end
