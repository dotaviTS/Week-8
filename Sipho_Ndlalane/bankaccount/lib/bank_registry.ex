defmodule BankRegistry do

 def start_link do
  Registry.start_link(keys: :unique, name: BankRegistry)
  end
end
