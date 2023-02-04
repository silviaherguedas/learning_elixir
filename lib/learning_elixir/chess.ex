defmodule LearningElixir.Chess do
  @moduledoc """
  Genserver para simular un reloj de ajedrez
  """
  use GenServer

  # client
  def start_link([partida: _time] = args) do
    GenServer.start_link(__MODULE__, args)
  end

  def cambiar_turno(pid) do
    GenServer.cast(pid, :cambiar_turno)
  end

  defp partida() do
    Process.send_after(self(), :partida, 1000)
  end

  # server
  @impl GenServer
  def init([partida: time]) do
    IO.puts "init"
    partida()

    {:ok, %{p_01: time, p_02: time, turno: "p_01"}}
  end

  @impl GenServer
  def handle_info(:partida, %{p_01: time01, p_02: time02, turno: turno} = state) do
    IO.puts "handle_info:partida"
    new_state =
      if turno == "p_01",
        do: %{p_01: time01 - 1, p_02: time02, turno: turno},
        else: %{p_01: time01, p_02: time02 - 1, turno: turno}

    cond do
      time01 <= 0  or  time02 <= 0 ->
        ganador = if turno == "Jugador 1", do: turno, else: "Jugador 2"
        {:stop, "Fin de la partida. Ganador: " <> ganador, state}

      true ->
        partida()
        {:noreply, new_state}
    end
  end

  @impl GenServer
  def handle_cast(:cambiar_turno, %{p_01: time01, p_02: time02, turno: turno}) do
    IO.puts "handle_cast:cambiar_turno"
    new_state =
      if turno == "p_01",
        do: %{p_01: time01, p_02: time02, turno: "p_02"},
        else: %{p_01: time01, p_02: time02, turno: "p_01"}
    partida()

    {:noreply, new_state}
  end

  def run do
    {:ok, pid} = start_link([partida: 10])
    cambiar_turno(pid)
    cambiar_turno(pid)
    cambiar_turno(pid)
  end
end
