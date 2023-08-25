defmodule BankRegistry do
  def start_link do
    :global.register_name(BankRegistry, self())
    Registry.start_link(keys: :unique, name: BankRegistry)
  end
end
