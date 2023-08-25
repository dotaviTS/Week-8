defmodule BankRegistry do
  #use Registry

  def start_link do
    :global.register_name(BankRegistry, self())
    # :global.register_name({BankRegistry,from_account}, self())
    Registry.start_link(keys: :unique, name: BankRegistry)
  end
end
