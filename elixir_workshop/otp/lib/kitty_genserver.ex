defmodule KittyGenServer do
  use GenServer

  defmodule Cat do
    defstruct name: nil, color: :black, description: nil
  end

  # ----------
  # Client API
  # ----------

  def start_link(cats \\ []) when is_list(cats) do
    GenServer.start_link(__MODULE__, cats, name: __MODULE__)
  end

  def order(pid, name, color, description) do
    GenServer.call(pid, {:order, name, color, description})
  end

  def return(pid, %Cat{} = cat) do
    GenServer.cast(pid, {:return, cat})
  end

  def close_shop(pid) do
    GenServer.stop(pid, :normal)
  end

  # ----------
  # Server API
  # ----------

  def init(cats) do
    {:ok, cats}
  end

  def handle_call({:order, name, color, description}, _from, cats) do
    case cats do
      [] ->
        cat = %Cat{name: name, color: color, description: description}
        {:reply, cat, cats}

      [cat | cats] ->
        {:reply, cat, cats}
    end
  end

  def handle_cast({:return, cat}, cats) do
    {:noreply, [cat | cats]}
  end

  def terminate(reason, _cats) do
    exit(reason)
  end
end
