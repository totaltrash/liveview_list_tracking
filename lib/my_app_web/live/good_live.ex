defmodule MyAppWeb.GoodLive do
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
      <.list pets={@pets} let={pet}>
        <%= pet %>
      </.list>
      <%= live_patch "Patch", to: Routes.live_path(@socket, __MODULE__) %>
      <%= @random %>
      <p>
        Clicking patch sends the following message back to the client (only the random number has been updated:)
      </p>
      <pre>
        ["4","6","lv:phx-Fv99fQV-R6wxlCFC","phx_reply",{"response":{"diff":{"0":{"2":"5506"}}},"status":"ok"}]
      </pre>
    """
  end

  def list(assigns) do
    ~H"""
    <ul>
      <%= for pet <- @pets do %>
        <li><%= render_slot(@inner_block, pet) %></li>
      <% end %>
    </ul>
    """
  end

  def handle_params(_params, _url, socket) do
    {:noreply, assign(socket, random: System.unique_integer([:positive]))}
  end
end
