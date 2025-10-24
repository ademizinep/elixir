defmodule BananaBank.ViaCep.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  def call(cep) do
    "/#{cep}/json"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 400}}) do
    {:error, :invalid_cep}
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_response({:error, _reason}) do
    {:error, :internal_server_error}
  end
end
