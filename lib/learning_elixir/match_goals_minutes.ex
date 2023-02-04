defmodule LearningElixir.MatchGoalsMinutes do
  @doc """
  Genserver para controlar los goles de un partido. Devuelve los minutos en los que se han metido un gol.
  """
  use GenServer

  def run do
    {:ok, pid} = start_link()
    Process.sleep(2000)
    gol(pid, :local)
    Process.sleep(2000)
    gol(pid, :local)
    Process.sleep(1000)
    gol(pid, :visitante)
    resultado(pid)
  end

  # client
  def start_link(args \\ %{}) do
    GenServer.start_link(__MODULE__, args)
  end

  def gol(pid, element) do
    GenServer.cast(pid, element)
  end

  def resultado(pid) do
    GenServer.call(pid, :get)
  end

  # server
  @impl GenServer
  def init(_args) do
    IO.puts "init"
    Process.send_after(self(), :end, :timer.minutes(10))
    # 90 * 60 * 1000

    {:ok, [l: [], v: [], start: Time.utc_now()]}
  end

  @impl GenServer
  def handle_call(:get, _from, state) do
    IO.puts "handle_call:get"

    {:reply, state, state}
  end

  @impl GenServer
  def handle_cast(:local, [l: local, v: visitante, start: start]) do
    IO.puts "handle_cast:local"
    diff = Time.diff(Time.utc_now(), start)
    IO.puts(diff)

    {:noreply, [l: [Integer.to_string(diff) | local], v: visitante, start: start]}
  end

  @impl GenServer
  def handle_cast(:visitante,  [l: local, v: visitante, start: start]) do
    IO.puts "handle_cast:visitante"
    diff = Time.diff(Time.utc_now(), start)
    IO.puts(diff)

    {:noreply, [l: local, v: [Integer.to_string(diff) | visitante], start: start]}
  end

  @impl GenServer
  def handle_info(:end, state) do
    IO.puts "handle_info:end"
    {:stop, "Fin del partido", state}
  end
end
