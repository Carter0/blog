defmodule BlogWeb.SigninLive do
  use BlogWeb, :live_view

  def render(assigns) do
    ~H"""
    Sign in page <.input field={@form[:email]} type="email" />
    """
  end
end
