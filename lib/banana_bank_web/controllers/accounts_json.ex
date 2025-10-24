defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account

  def create(%{account: account}) do
    %{
      message: "Account created successfully",
      data: data(account)
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      balance: account.balance,
      user_id: account.user_id
    }
  end

  def transaction(%{transaction: %{withdraw: withdraw_account, deposit: deposit_account}}) do
    %{
      message: "Transaction created successfully",
      withdraw_account: data(withdraw_account),
      deposit_account: data(deposit_account)
    }
  end
end
