defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @required_params_create [:name, :email, :password, :cep]
  @required_params_update [:name, :email, :cep]

  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :email, :string
    field :password_hash, :string
    field :cep, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params_create)
    |> validate_required(@required_params_create)
    |> validate_length(:password, min: 6)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params_update)
    |> validate_required(@required_params_update)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
  end


  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp add_password_hash(changeset), do: changeset
end
