defmodule BananaBank.Users.Verify do
  alias BananaBank.Users

  def call(%{"id" => id, "password" => password}) do
    IO.inspect(id, label: "id")
    case Users.get(id) do
      {:ok, user} -> verify(password, user)
      {:error, _} = error -> error
    end
  end

  defp verify(password, user) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end
