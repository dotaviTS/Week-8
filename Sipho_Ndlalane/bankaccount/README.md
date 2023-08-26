## Practical Question                                                                                                            (60 Marks)
### Write tests using ExUnit to cover the following scenarios:

1. Initial Balance: Verify that the bank account starts with the correct initial balance.                                              (10)
2. Deposit: Verify that depositing money increases the balance correctly.                                                              (10)
3. Withdraw with Sufficient Funds: Verify that withdrawing money decreases the balance correctly when there are sufficient funds.      (10)
4. Withdraw with Insufficient Funds: Verify that an attempt to withdraw more money than is available in the account returns an "Insufficient funds" error. (10)
5. Concurrent Deposits and Withdrawals: Write a test that spawns multiple processes to make concurrent deposits and withdrawals, ensuring that the final balance is as expected.   (10)

### Use appropriate assertions to ensure that each scenario is thoroughly tested. Consider edge cases, such as negative deposit amounts or initial balances.

## Bonus Marks

### Generate exDoc documentation for your project. (5)

### Generate a test coverage report for your project.  (5)
Email me your test coverage percentage report and percentage of lines covered.

## Hints and Tips

1. **Understanding BankAccount Module**: Take some time to understand the BankAccount module before writing tests. Look at the function signatures, input parameters, and expected output.

2. [ExUnit documentation](https://hexdocs.pm/ex_unit/ExUnit.html)

3. **Async Testing**: For concurrent testing, remember to include `async: true` in your test module. This allows tests within the module to run concurrently with each other.

4. **Edge Cases**: Think about potential edge cases, such as negative deposit amounts or withdrawing more money than available. These scenarios should also be tested to ensure robustness.

5. **Clear Test Descriptions**: Write clear and descriptive test names. This helps others understand what each test is doing and why it's important.

6. **Running Specific Tests**: If you want to run a specific test or set of tests during development, you can use the `mix test` command with a path or line number. For example: `mix test test/bankaccount_test.exs:39`.

7. **Test Coverage**: Achieving 100% test coverage is challenging but rewarding. It ensures that every part of the code is tested. 


9. **Comment Your Tests**: Include comments in your tests to explain what you are testing and why. It helps future developers (including yourself) understand the purpose and context of each test.

Remember, the goal is not just to write tests but to write meaningful tests that validate the functionality and robustness of your code


### Maythe4thbewithyou



# BankAccount

BankAccount is a simple Elixir module designed to manage a virtual bank account. Users can create an account, deposit and withdraw funds, and check their balance. Ideal for learning Elixir and understanding basic banking operations.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bankaccount` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bankaccount, "~> 0.1.0"}
  ]
end
```

## User Guide

Navigate to Your Project Directory: First, navigate to your project directory in the command line:

```elixir
cd path/to/your/project
```

Compile Your Project: Compile your project using the mix build tool:
```
mix compile
```
Start an Interactive Elixir Shell: You can start an interactive Elixir shell with your project using:
```
iex -S mix or iex.bat -S mix in Windows
```
Interact with the BankAccount Module: Once inside the interactive shell, you can call the functions defined in your BankAccount module. Here's an example:
```
{:ok, pid} = BankAccount.start_link(1000)
BankAccount.deposit(pid, 200)
balance = BankAccount.balance(pid)
```
Gracefully exit the Interactive Shell by typing:
```
:init.stop
```
### Starting the BankAccount

Start a new bank account with an initial balance:

```elixir
{:ok, pid} = BankAccount.start_link(1000)
```

### Deposit Money

Deposit a specified amount into the bank account:

```elixir
BankAccount.deposit(pid, 200)
```

### Withdraw Money

Withdraw a specified amount from the bank account:

```elixir
BankAccount.withdraw(pid, 200)
```

### Check Balance

Retrieve the current balance of the bank account:

```elixir
balance = BankAccount.balance(pid)
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bankaccount>.
