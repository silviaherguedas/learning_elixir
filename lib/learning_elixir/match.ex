defmodule LearningElixir.Match do
  @moduledoc """
  Genserver para controlar los goles de un partido, después de 'x' minutos se para e informa del resultado.
  """
  use GenServer

  def run do
    {:ok, pid} = start_link()

    gol(pid, :local)
    gol(pid, :local)
    gol(pid, :visitante)
    resultado(pid)
  end

  # client
  def start_link(args \\ %{}) do
    IO.puts "Después de 2 min, se termina el partido"
    GenServer.start_link(__MODULE__, args)
  end

  @spec gol(pid, atom) :: :ok
  def gol(pid, element) do
    GenServer.cast(pid, element)
  end

  @spec resultado(pid) :: tuple
  def resultado(pid) do
    GenServer.call(pid, :get)
  end

  # server
  @impl GenServer
  def init(_args) do
    IO.puts "init"
    Process.send_after(self(), :end, :timer.minutes(2))
    # 90 * 60 * 1000

    {:ok, {0,0}}
  end

  @impl true
  def handle_call(:get, _from, state) do
    IO.puts "handle_call:get"
    {:reply, state, state}
  end

  @impl true
  def handle_cast(:local, {local, visitante}) do
    IO.puts "handle_cast:local"

    {:noreply, {local + 1, visitante}}
  end

  @impl true
  def handle_cast(:visitante,  {local, visitante}) do
    IO.puts "handle_cast:visitante"
    {:noreply, {local, visitante + 1}}
  end

  @impl GenServer
  def handle_info(:end, {local, visitante}) do
    IO.puts "handle_info:end"
    {:stop, "Fin del partido: #{local}, #{visitante}", {local, visitante}}
  end

end
