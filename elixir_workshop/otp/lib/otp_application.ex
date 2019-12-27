defmodule OtpApplication do
  use Application

  def start(_type, _args) do
    children = [
      {StackSupervisor, strategy: :one_for_one, name: StackSupervisor},
      {KittySupervisor, strategy: :one_for_one, name: KittySupervisor},
    ]

    Supervisor.start_link(children, strategy: :rest_for_one, name: __MODULE__)
  end
end
