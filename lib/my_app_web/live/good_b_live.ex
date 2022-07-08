defmodule MyAppWeb.GoodBLive do
  use MyAppWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(pets: ["cat", "dog", "bird"])
      |> assign(random: System.unique_integer([:positive]))

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Example with wrapper - all good</h1>
    <.wrapper>
      <.list pets={@pets} />
      <%= live_patch "Patch", to: Routes.live_path(@socket, __MODULE__) %>
      <%= @random %>
      <p>
      Clicking patch sends the following message back to the client (only the random number has been updated:)
      </p>
      <pre>
        ["4","6","lv:phx-Fv9-uTRWqFO_hhoh","phx_reply",{"response":{"diff":{"0":{"0":{"0":{"2":"7748"}}}}},"status":"ok"}]
      </pre>
    </.wrapper>
    """
  end

  def list(assigns) do
    ~H"""
    <ul>
      <%= for pet <- @pets do %>
        <li><%= pet %></li>
      <% end %>
    </ul>
    """
  end

  def wrapper(assigns) do
    ~H"""
    <div>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def handle_params(_params, _url, socket) do
    {:noreply, assign(socket, random: System.unique_integer([:positive]))}
  end
end
