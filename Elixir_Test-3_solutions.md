Test Solutions

Question 1: What is the primary role of a Supervisor in Elixir?
- answer: b) Restarting Processes

Question 2: Given the following code, what will be the initial balance of a BankAccount?
- answer: c) 500
BankAccount is initialized with an argument of 500, so the initial balance is set to that value.

Question 3: What does the :one_for_one strategy mean in a Supervisor?
- answer: b) Restart only the failing child
the :one_for_one strategy restarts only the failing child process, leaving the others untouched

Question 4: Which function is used to make a synchronous call to a GenServer?
- answer: c) call

Question 5: How can you ensure that a GenServer is terminated properly?
- answer: c) Use the terminate/2 callback
Implementing the terminate/2 callback ensures that the server can clean up resources properly before termination.

Question 6: What is the purpose of the init/1 function in a GenServer?
- answer: c) To initialize the server state
init/1 initializes the state of the GenServer.

Question 7: What does MODULE refer to, in the context of GenServers?
- b) The current module
__MODULE__ refers to the current module in which it's used.

Question 8: How would you run a function in parallel in Elixir?
- answer: c) Task.async
The Task.async function allows you to run a function in parallel.

Question 9: What will be the output of the following code snippet?
- answer: c) 7
 a is assigned 3 and b is assigned 4. The sum of a + b is 7.

Question 10: In the following pattern match, what will the value of c be after the code is executed?
- answer: a) 3
After pattern matching, a is [1, 2 | 3], and c is 3.

Question 11: What will the following code snippet return?
- answer: b) 2
The value of b is %{y: 2}, so b[:y] returns 2.

Question 12: What will the following code snippet return?
- answer: b) [4, 1, 2, 3]
Using the | operator prepends the value to the list.

Question 13: What will be the result of this code snippet?
- answer: a) An error will be raised
:ok is an atom, not a list, so attempting to pattern match as if it were a list will raise an error.

Question 14: What will be the value of result after the following code snippet is executed?
- answer: c) [2, 3 | 4]
The value of c after pattern matching will be [2, 3 | 4].

Question 15: What network scanning tool does Trinity use in the Cult Movie, The Matrix, to portscan the Electric company's network for open ports?
- answer: a) nmap
In the movie "The Matrix," Trinity uses the nmap tool to perform a port scan.


## SECTION 2 A: Programming Question (10 marks)

- Q1: b) rest_for_one
- Q2: c) Only the crashed process and the ones started after it will be restarted.
- Q3: b) By the sensor type
- Q4: c) The Registry module needs to be changed to Global.
- Q5: b) Naming processes uniquely
- Q6: a) GenServer
- Q7: b) All processes would be terminated and restarted if one crashes.
- Q8: c) Global
- Q9: b) They all crash as well.
- Q10: a) Use the :rest_for_one strategy.

Section 2 B: Programming Question (10 marks)
- d) or a)
```elixir
def get_value(pid) do
  GenServer.call(pid, :get_value)
end

def update_value(pid, value) do
  GenServer.call(pid, {:update_value, value})
end
```
- Q1: b)

```elixir
test "get and update value" do
  {:ok, pid} = WeatherSensor.start_link(:temperature, 20)
  assert WeatherSensor.get_value(pid) == 20
  WeatherSensor.update_value(pid, 25)
  assert WeatherSensor.get_value(pid) == 25
end
```

the proper implementation of get_value/1 and update_value/2 is d.
the correct test snippet is option b.
