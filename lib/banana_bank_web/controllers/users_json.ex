defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User
  def create(%{user: user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      cep: user.cep,
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end

  def get(%{user: user}), do: %{data: data(user)}

  def update(%{user: user}) do
    %{
      message: "User updated successfully",
      data: data(user)
    }
  end

  def delete(_), do: %{message: "User deleted successfully"}

  def login(%{token: token}) do
    %{
      message: "Login successful",
      token: token
    }
  end
end
