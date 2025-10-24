defmodule BananaBank.Accounts.Transaction do
  alias BananaBank.Accounts
  alias BananaBank.Repo
  alias Accounts.Account
  alias Ecto.Multi

  def call(%{"withdraw_account_id" => withdraw_account_id, "deposit_account_id" => deposit_account_id, "amount" => amount}) do
    with %Account{} = withdraw_account <- Repo.get(Account, withdraw_account_id),
         %Account{} = deposit_account <- Repo.get(Account, deposit_account_id),
         {:ok, _value} <- Decimal.cast(amount) do
      Multi.new()
      |> withdraw(withdraw_account, amount)
      |> deposit(deposit_account, amount)
      |> Repo.transaction()
      |> handle_transaction()
    else
      nil -> {:error, :not_found}
      :error -> {:error, :invalid_amount}
    end
  end

  def call(_), do: {:error, :invalid_params}

  defp withdraw(multi, account, value) do
    new_balance = Decimal.sub(account.balance, value)
    changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp deposit(multi, account, amount) do
    new_balance = Decimal.add(account.balance, amount)
    changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end

  defp handle_transaction({:ok, _result} = result) do
    result
  end

  defp handle_transaction({:error, _op, reason, _values}) do
    {:error, reason}
  end
end
