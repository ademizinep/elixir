defmodule BananaBank.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias BananaBank.Users.User

  @required_params_create [:balance, :user_id]
  @required_params_update [:balance]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params_create)
    |> validate_required(@required_params_create)
    |> check_constraint(:balance, name: :balance_must_be_positive)
    |> unique_constraint(:user_id, name: :accounts_user_id_unique)
  end

  def changeset(account, params) do
    account
    |> cast(params, @required_params_update)
    |> validate_required(@required_params_update)
    |> check_constraint(:balance, name: :balance_must_be_positive)
    |> unique_constraint(:user_id, name: :accounts_user_id_unique)
  end
end
