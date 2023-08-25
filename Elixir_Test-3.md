## TS - Develoepr Internship
### Elixir Test - 25th August 2023

### Max Time : 90 minutes

### Please read the instructions carefully before attempting the test.

### INSTRUCTIONS

#### This test is comprised of 3 sections. 

#### This is a closed book exam. You are not allowed to refer to any external resources.

#### Clearly write your name, surname and email address on the top of the blank a4 page. Number your solutions as per the questions. Only write your solutions on the page. Do not write any other notes on the page.


## SECTION 1: Multiple Choice Questions (10 marks)

1. What is the primary role of a Supervisor in Elixir?
a) Logging Errors
b) Restarting Processes
c) Compiling Code
d) Generating Documentation

2. Given the following code, what will be the initial balance of a BankAccount?

```elixir
defmodule BankSupervisor do
  use Supervisor
  def init(:ok) do
    children = [{BankAccount, 500}]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
```
a) 0
b) 100
c) 500
d) 1000

3. What does the :one_for_one strategy mean in a Supervisor?
a) Restart all children if one child fails
b) Restart only the failing child
c) Restart the failing child and its siblings
d) Do not restart any children

4. Which function is used to make a synchronous call to a GenServer?
a) cast
b) apply
c) call
d) fetch

5. How can you ensure that a GenServer is terminated properly?
a) Kill the process
b) Send a termination signal
c) Use the terminate/2 callback
d) Call System.exit/1

6. What is the purpose of the init/1 function in a GenServer?
a) To start the server
b) To handle requests
c) To initialize the server state
d) To monitor the server

7. What does __ MODULE __ refer to, in the context of GenServers?
a) The GenServer module
b) The current module
c) The parent module
d) The supervisor module

8. How would you run a function in parallel in Elixir?
a) Parallel.run
b) Concurrency.spawn
c) Task.async
d) Agent.start

9. What will be the output of the following code snippet?

```elixir
list = [1, 2, [3, 4]]
[_, _, [a, b]] = list
a + b
```

a) 3
b) 4
c) 7
d) an error


10. In the following pattern match, what will the value of c be after the code is executed?
  
  ```elixir 
%{x: a, y: b} = %{x: [1, 2 | 3], y: [4, 5]}
[a, b | c] = a
c

```

a) 3
b) 2
c) [2, 3]
d) an error
e) nil

11. What will the following code snippet return?

```elixir
[a, b, c] = [1, %{y: 2}, [3]]
b[:y]
```

a) 1
b) 2
c) 3
d) an error
e) nil
f) {2}

12. What will the following code snippet return?

```elixir
list = [1, 2, 3]
list = [4 | list]
list
```

a) [1, 2, 3, 4]
b) [4, 1, 2, 3]
c) [4, 1, 2, 3, 4]
d) an error

13. What will be the result of this code snippet?
  
  ```elixir
  [first | second] = :ok
  ```

a) An error will be raised
b) first = :o, second = :k
c) first = :ok, second = []
d) first = :ok, second = nil
e) first = :ok, second = :ok
f) first = :ok, second = [k]
g) second = :ok, first = []
h) second = :ok, first = nil
i) second = :ok, first = :ok
j) second = :o, first = [k]

14. What will be the value of result after the following code snippet is executed?

```elixir
%{a: [b | c]} = %{a: [1, [2, 3 | 4]]}
result = c
```

a) [3, 4]
b) 4
c) [2, 3 | 4]
d) 3
e) an error

15. What network scanning tool does Trinity use in the 1999 Cult Movie,The Matrix, to portscan the Electric company's network for open ports?

a) nmap
b) netstat
c) tracert
d) ping
e) ifconfig
f) netcat
g) Lexmark scanner
h) Security Guard's Wand

## SECTION 2 A: Programming Question (10 marks)

Programming Questions - 25/25 Marks

```elixir
defmodule WeatherStation do
  use Application

  def start(_type, _args) do    
    children = [
      {Weather.StationSupervisor, strategy: :rest_for_one}
    ]
    
    opts = [strategy: :rest_for_one, name: Weather.StationSupervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule Weather.StationSupervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      {WeatherSensor, :temperature},
      {WeatherSensor, :humidity},
      {Registry, keys: :unique, name: WeatherRegistry}
    ]
    Supervisor.init(children, strategy: :rest_for_one)
  end
end

defmodule WeatherSensor do
  use GenServer

  def start_link(type, initial_value) do
    GenServer.start_link(__MODULE__, initial_value, name: {:via, Registry, {WeatherRegistry, type}})
  end

   
end
```


Q1: What is the restart strategy used in the Weather.StationSupervisor module?
a) one_for_one
b) rest_for_one
c) one_for_all
d) simple_one_for_one


Q2: What would happen if a WeatherSensor process crashes under the given supervision strategy?
a) Only the crashed process will be restarted.
b) All the sibling processes will be terminated and restarted.
c) Only the crashed process and the ones started after it will be restarted.
d) The process won't be restarted.


Q3: How are WeatherSensors uniquely identified in the given code?
a) By the process ID
b) By the sensor type
c) By the initial value
d) By the module name


Q4: If a global registry is used instead of a local one, what change would need to be made?
a) The application module needs to be altered.
b) The sensor type needs to be changed.
c) The Registry module needs to be changed to Global.
d) No change is needed.


Q5: In the given code, what purpose does the WeatherRegistry serve?
a) Storing weather data
b) Naming processes uniquely
c) Managing process lifecycles
d) Scheduling concurrent tasks


Q6: What concurrency pattern is used to handle WeatherSensors?
a) GenServer
b) Agent
c) Task
d) GenEvent


Q7: What would be the impact if the strategy is changed to :one_for_all in Weather.StationSupervisor?
a) Only the crashed process would be restarted.
b) All processes would be terminated and restarted if one crashes.
c) No impact on the code.
d) The code would not compile.


Q8: Which module can be used to handle global registries?
a) Process
b) GenServer
c) Global
d) Agent


Q9: If the Weather.StationSupervisor crashes, what would happen to its children?
a) They continue running.
b) They all crash as well.
c) Only the WeatherSensor processes crash.
d) The application restarts.


Q10: How can you ensure that a specific WeatherSensor process is started only after another has been initialized?
a) Use the :rest_for_one strategy.
b) Use the :one_for_one strategy.
c) Use the :one_for_all strategy.
d) Start them in the same function.

## Section 2 B: Programming Question (10 marks)

1) Which of the following code snippets correctly implements the get_value/1 and update_value/2 functions inside the WeatherSensor module to fetch and update the current value of a given sensor type?

a) 
```elixir
def get_value(pid) do
  GenServer.call(pid, :get_value)
end

def update_value(pid, value) do
  GenServer.cast(pid, {:update_value, value})
end
```

b) 
```elixir
def get_value(pid) do
  GenServer.call(pid, value)
end

def update_value(pid, value) do
  GenServer.cast(pid, value)
end
```

c) 
```elixir
def get_value(pid) do
  GenServer.cast(pid, :get_value)
end

def update_value(pid, value) do
  GenServer.call(pid, {:update_value, value})
end
```

d) 
```elixir
def get_value(pid) do
  GenServer.call(pid, :get_value)
end

def update_value(pid, value) do
  GenServer.call(pid, {:update_value, value})
end
```



Q1: How would you write an ExUnit test to verify the get_value and update_value functions?

a) 
```elixir
test "get and update value" do
  assert WeatherSensor.get_value(:temperature) == 20
  WeatherSensor.update_value(:temperature, 25)
  assert WeatherSensor.get_value(:temperature) == 25
end
```

b) 
```elixir
test "get and update value" do
  {:ok, pid} = WeatherSensor.start_link(:temperature, 20)
  assert WeatherSensor.get_value(pid) == 20
  WeatherSensor.update_value(pid, 25)
  assert WeatherSensor.get_value(pid) == 25
end
```

c) 
```elixir
test "get and update value" do
  {:ok, pid} = WeatherSensor.start_link(:temperature)
  assert WeatherSensor.get_value(pid) == 20
  WeatherSensor.update_value(:temperature, 25)
  assert WeatherSensor.get_value(pid) == 25
end
```

d) 
```elixir
test "get and update value" do
  {:ok, pid} = WeatherSensor.start_link(:temperature, 20)
  assert WeatherSensor.get_value(:temperature) == 20
  WeatherSensor.update_value(:temperature, 25)
  assert WeatherSensor.get_value(:temperature) == 25
end
```

e) none of the above


