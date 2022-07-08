defmodule MyAppWeb.BadLive do
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
    <h1>Example with wrapper and slotted component - bad</h1>
    <.wrapper>
      <.list pets={@pets} let={pet}>
        <%= pet %>
      </.list>
      <%= live_patch "Patch", to: Routes.live_path(@socket, __MODULE__) %>
      <%= @random %>
      <p>
        Clicking patch sends the following message back to the client (the list assigns are resent:)
      </p>
      <pre>["4","6","lv:phx-Fv99jgLmaUEKdRlE","phx_reply",{"response":{"diff":{"0":{"0":{"0":{"0":{"0":{"d":[[{"0":"cat","s":0}],[{"0":"dog","s":0}],[{"0":"bird","s":0}]],"p":{"0":["\n    ","\n  "]}}},"2":"5538"}}}}},"status":"ok"}]</pre>
    </.wrapper>
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
