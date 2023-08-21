# Part 5: Distributed Systems in Elixir

## Table of Contents

1. **Introduction to Distributed Systems**
2. **Understanding Nodes and Remote Connections**
   - Example 5.1: Connecting Nodes Manually
3. **Distributed Registry and Process Management**
   - 5.2.1 Implementing a Distributed Registry
   - 5.2.2 Creating and Managing Processes Across Nodes
4. **Distributed Transactions and Atomic Operations**
   - Example 5.3: Perform a Transfer Between Accounts on Different Nodes
5. **Monitoring and Managing Distributed Systems**
   - 5.4.1 Telemetry
6. **TSBank - New Feature: Transaction History Feature in BankAccount**
   - Step 1: Define a Transaction Structure
   - Step 2: Update the BankAccount State
   - Step 3: Record Transactions
   - Step 4: Implement Transaction History Retrieval
   - Step 5: Formatting and Displaying Transactions
   - Step 6: Testing
   - Step 7: Enhancements
   - Understanding the State
   - Conclusion

### Exercises

#### Distributed Systems
- Exercise 5.1: Explore Node Disconnection
- Exercise 5.2: Handle Network Partitions
- Exercise 5.3: Visualize System Information
- Exercise 5.2: Explore Distributed Registry
- Exercise 5.3: Remote Process Management
- Exercise 5.4: Implement Two-Phase Commit
- Exercise 5.5: Implement Distributed System Monitoring


#### Transaction History Feature in BankAccount

#### To Be done in Parallel with the coursework this week

- Exercise 5A: Modify the withdraw and transfer functions to record transactions.
- Exercise 5B: Implement the handle_call for transaction history retrieval and write a private function to apply filters.
- Exercise 5C: Write a function to format the transaction history. Look at the library Tabula.ex for inspiration.
- Exercise 5D: Write ExUnit tests to verify the transaction history feature.
- Exercise 5E: Implement one or more enhancements as described above.



## Introduction to Distributed Systems

Distributed systems enable parallel computation, enhance fault tolerance, and facilitate resource sharing by connecting multiple individual machines, known as nodes. These nodes work together to achieve common tasks and provide a cohesive system, improving performance, scalability, and resilience. Elixir, leveraging the capabilities of the Erlang virtual machine (BEAM), offers intrinsic support for distributed computing. This section explores foundational concepts and practical aspects of distributed systems, providing hands-on examples and exercises to deepen understanding.

### We will cover the following areas:

1. **Nodes and Remote Connections**: Understanding how to create and manage nodes in Elixir, enabling communication and collaboration within the distributed system.
2. **Distributed Registry and Process Management**: Techniques to register and manage processes across different nodes, facilitating cross-node communication and coordination.
3. **Distributed Transactions and Atomic Operations**: Implementing distributed transactions to ensure consistency and atomicity across multiple nodes, including two-phase commit protocols.
4. **Monitoring and Managing Distributed Systems**: Tools and strategies to monitor and manage distributed systems, including Telemetry and the Observer tool.

#### Nodes and Remote Connections
In distributed systems, nodes are individual instances of the Erlang virtual machine that can run independently or be connected to form a cluster. Communication between nodes happens through message passing, a unifying approach to concurrency and distribution.

```mermaid
graph TD
    A[Node 1] --> B[Node 2]
    A --> C[Node 3]
    B --> C
```

#### Distributed Registry and Process Management
Processes can be registered and accessed globally within a connected cluster of nodes. This functionality allows for building features that require cross-node communication and coordination.

```mermaid
graph LR
    A[Node 1: Process A] --> B[Node 2: Process B]
    B --> C[Node 3: Process C]
    C --> A
```

#### Distributed Transactions and Atomic Operations
Distributed transactions ensure that operations across multiple nodes are carried out atomically. All parts of the transaction either succeed together or fail together, maintaining consistency.

```mermaid
sequenceDiagram
    participant Coordinator
    participant Node1
    participant Node2
    Coordinator->>Node1: Prepare
    Coordinator->>Node2: Prepare
    Node1-->>Coordinator: Ready
    Node2-->>Coordinator: Ready
    Coordinator->>Node1: Commit
    Coordinator->>Node2: Commit
```

#### Monitoring and Managing Distributed Systems
Effective monitoring and management of distributed systems are vital for understanding system behavior, performance, and reliability. Tools like Telemetry and the Observer provide valuable insights.

```mermaid
graph TD
    A[Observer] --> B[Node 1]
    A --> C[Node 2]
    A --> D[Node 3]
```




### 5.1 Understanding Nodes and Remote Connections

Nodes in Elixir are individual instances of the Erlang virtual machine. They can run isolated or be connected to form a distributed system. Communication between nodes happens through message passing, unifying the approach to concurrency and distribution.

#### Example 5.1: Connecting Nodes Manually

##### Step 1: Start Two Nodes

```bash
# Terminal 1
iex --name node1@127.0.0.1

# Terminal 2
iex --name node2@127.0.0.1
```

Starting two nodes with unique names allows them to communicate and identify each other.

##### Step 2: Connect Nodes - Use 2 different terminals here

```bash
# In Terminal 1
Node.connect(:"node2@127.0.0.1")
# Verify with
Node.list() # on both terminals
```
This step establishes the connection between the two nodes, allowing them to send messages to each other.

##### Step 3: Send Messages Between Nodes

```bash
# On node1
Node.spawn(:"node2@127.0.0.1", fn -> IO.puts("Hello from node2"); Process.sleep(10000) end)
```
This code snippet spawns a process on node2 but displays the output on node1, showing the ease of remote execution. Although the process runs on node2, the output is displayed on node1. Elixir displays messages from remote nodes in the format `{:node, message}`. In this case, the message is `Hello from node2`. The `Process.sleep/1` function is used to keep the process alive for 10 seconds. This allows us to inspect the process on node2. 

```bash
# On node2
Process.list()
```
This command lists all processes running on node2. You should see the process spawned from node1.

##### Step 4: Inspect the Remote Process

```elixir
# On node2
Process.info(#PID<XXXX.XXX.XXX>)
```
Inspecting a remote process provides insights into its current state, such as memory usage and status.

##### Step 5: Disconnect Nodes

On either node
```elixir
Node.disconnect(:"node2@127.0.0.1")
```
Disconnecting nodes can help in simulating network failures and understanding how the system behaves under such conditions. 

#### Exercise 5.1: Explore Node Disconnection

- **Description**: Experiment with disconnecting the nodes you created earlier. See how your system responds and try to reconnect them.
- **Hint**: Use `Node.disconnect/1` and `Node.connect/1`.
- **Sample Task**: Disconnect nodes, then reconnect and verify the connection using `Node.list()`.

#### Exercise 5.2: Handle Network Partitions

- **Description**: Simulate network partitions and reconnecting nodes. Observe how message passing is affected.
- **Hint**: Utilize `:net_kernel.disconnect/1` and `:net_kernel.connect/1`.
- **Sample Task**: Create a network partition, send messages between nodes, and observe the behavior.

#### Exercise 5.3: Visualize System Information

- **Description**: Use the Observer tool to visualize system and process information.
- **Hint**: Run `:observer.start/0` to start the Observer tool.
- **Sample Task**: Start the Observer and explore different tabs like "Load Charts," "Applications," and "Processes."

#### Further Exploration:

1. **Running Functions on Different Nodes**: Execute various functions on different nodes to understand remote execution.
2. **Disconnecting and Reconnecting Nodes**: Experiment with disconnecting and reconnecting nodes to simulate network issues.
3. **Monitoring Processes Across Nodes**: Use `Process.monitor/1` to monitor processes across nodes.
4. **Observer Tool**: Utilize the `:observer.start/0` tool for a graphical view of the system.
5. **Exploring Process Information**: Use functions like `Process.list/0` to explore processes on a node.
6. **Handling Errors Across Nodes**: Explore mechanisms to handle errors and failures in a distributed system.

##### Note:

Nodes can be on the same machine or distributed across different machines, providing a flexible architecture for scalable applications. Understanding nodes and remote connections is foundational for building distributed systems in Elixir.

This example and exercises provide a hands-on introduction to distributed computing in Elixir. By exploring these concepts, you'll be well-equipped to develop scalable and fault-tolerant applications.


### 5.2 Distributed Registry and Process Management

Distributed systems often require global process management to enable communication and collaboration across different nodes. In Elixir, the `:global` module facilitates this by providing a way to register processes across nodes.

#### 5.2.1 Implementing a Distributed Registry

##### Explanation:

Elixir's `:global` registry allows processes to be registered and accessed globally within a connected cluster of nodes. This is essential for building features that require cross-node communication and coordination.

##### Example 5.2.1: Modify BankRegistry to Use `:global`

###### Step 1: Modify the Existing BankRegistry

```elixir
defmodule BankRegistry do
  use Registry
  
  def start_link do
    :global.register_name(BankRegistry, self())
    Registry.start_link(keys: :unique, name: __MODULE__)
  end
end
```

###### Step 2: Start the Modified BankRegistry on Both Nodes

```
# On both nodes
BankRegistry.start_link()
```

###### Step 3: Verify Cross-Node Registration
```

# On either node
:global.registered_names()
```

Note:
This code snippet demonstrates how to register a process across all connected nodes, allowing true distributed computation.

#### Exercise 5.2: Explore Distributed Registry
Description: Experiment with the :global module by creating, registering, and accessing processes across different nodes.
Hint: Utilize :global.register_name/2 and :global.whereis_name/1.
Sample Task: Register a process globally and then access it from another node.

- [MORE INFO](https://erlang.org/doc/man/global.html)


##### 5.2.2 Creating and Managing Processes Across Nodes
Explanation:
Creating and managing processes across nodes is a fundamental aspect of distributed systems. Elixir provides tools to spawn, monitor, and manage remote processes, enabling fault tolerance and load balancing.

#### Example 5.2.2: Create a Process on Another Node
Step 1: Start a Process on Node1
- Start a named process on Node1 that performs a specific task. Here's an example of starting a process that prints a message repeatedly:

```elixir
# On Node1
pid = spawn(fn -> 
  :timer.sleep(1000)
  IO.puts("Hello from Node1")
end)
```

Step 2: Monitor the Process from Node2
- On Node2, you can monitor the process created on Node1. This allows Node2 to receive notifications if the process on Node1 terminates.
```elixir
# On node2
Process.monitor(pid)
```

Step 3: Observe Behaviors
Experiment with killing and restarting the process to understand fault tolerance and load balancing. You can kill the process on Node1 using:

```elixir
# On Node1
Process.exit(pid, :kill)
```
And observe on Node2 that a message is received, indicating that the process has terminated.

```elixir
# On Node2
receive do
  {:DOWN, _ref, :process, _pid, reason} -> IO.puts("Process terminated because of #{reason}")
end
```

Fault Tolerance: Monitoring processes across nodes allows the system to detect failures and take corrective actions, such as restarting the process on another node.

Load Balancing: By spawning processes on different nodes, you can distribute the workload evenly, preventing any single node from becoming a bottleneck.

Process Communication: Processes on different nodes can communicate through message passing, just like local processes. This unifies the way you write concurrent and distributed code in Elixir.

Observing Distributed Systems: Tools like :observer.start can be used to visually inspect the state of distributed systems, including process connections across nodes.

#### Exercise 5.2

Build a Distributed Counter: Design a counter that can be incremented and read from different nodes. Use distributed processes to achieve synchronization.

#### Further Reading:
[Distributed Elixir Guide](https://elixir-lang.org/getting-started/mix-otp/distributed-tasks-and-configuration.html)

Erlang :rpc Module Documentation
This enhanced section provides a clearer understanding of how to create and manage processes across nodes in Elixir, along with practical examples and insights into related concepts. It also includes exercises and further reading to deepen understanding.


#### Exercise 5.3: Remote Process Management
Description: Create and manage processes on remote nodes, observing behaviors like fault tolerance and load balancing.
Hint: Use Node.spawn/2 and Process.monitor/1.
Sample Task: Spawn a process on a remote node, monitor it, and then intentionally kill it to observe recovery behavior.

[More Info](https://elixir-lang.org/getting-started/io-and-the-file-system.html#distributed-elixir)


#### Further Reading and Self-Study:

1. **Global Name Registration**: Experiment with registering names globally using `:global`. This allows processes to be accessed by a unique name across all connected nodes.
    - [Erlang Global Module Documentation](https://erlang.org/doc/man/global.html)
    
2. **Remote Process Monitoring**: Learn to monitor and manage remote processes. This is essential for observing the state and behavior of processes running on other nodes.
    - [Erlang Process Module Documentation](https://erlang.org/doc/man/erlang.html#process_info-2)
    
3. **Distributed Task Execution**: Explore running tasks across a cluster of nodes, allowing for parallel execution and improved efficiency.
    - [Elixir Task Module Documentation](https://hexdocs.pm/elixir/Task.html)
    
4. **Load Balancing**: Implement load balancing by distributing tasks across nodes. This ensures that no single node is overwhelmed, leading to better performance.
    - [Horde: A Distributed Supervisor Library](https://github.com/derekkraan/horde)

```mermaid
graph LR
    A[Load Balancer] --> B[Node 1]
    A --> C[Node 2]
    A --> D[Node 3]
```


Tools and Libraries: Explore tools like :rpc for remote procedure calls and libraries like Horde for distributed computing.
[:rpc Module Documentation](https://erlang.org/doc/man/rpc.html)
[Horde: A Distributed Supervisor Library](https://github.com/derekkraan/horde)



### 5.3 Distributed Transactions and Atomic Operations

#### Explanation:

Distributed transactions ensure that operations across multiple nodes are carried out atomically. This means that all parts of the transaction either succeed together or fail together, maintaining consistency across the system. Elixir provides mechanisms like two-phase commit to manage distributed transactions.

#### Example 5.3: Perform a Transfer Between Accounts on Different Nodes

##### Step 1: Start Accounts on Different Nodes

-   Register accounts with unique identifiers on different nodes.
-   Verify registration using `:global.whereis_name/1`.

##### Step 2: Implement a Transfer Function

```elixir
def transfer(from_account, to_account, amount) do
  from_pid = :global.whereis_name({BankRegistry, from_account})
  to_pid = :global.whereis_name({BankRegistry, to_account})
  # Perform transaction logic here, ensuring atomicity
end 
```

##### Step 3: Perform a Transfer and Verify the Transaction
- Invoke the transfer function with appropriate parameters.
- Verify that the transfer was successful, and the system state is consistent.


#### Exercise 5.4: Implement Two-Phase Commit
Description: Implement a two-phase commit protocol to ensure atomicity in distributed transactions. This involves a coordinator that controls the commit process across all participating nodes.
Hint: Use GenStateMachine or :gen_statem to handle transaction states. Understand the "Prepare" and "Commit" phases of the protocol.

#### Two-Phase Commit Protocol on Wikipedia
Sample Task: Design and implement a two-phase commit process for transferring funds between accounts on different nodes.

[(Two-Phase Commit)](https://en.wikipedia.org/wiki/Two-phase_commit_protocol)

```mermaid
sequenceDiagram
    participant Coordinator as Coordinator
    participant Node1 as Node1
    participant Node2 as Node2
    Coordinator->>Node1: Prepare
    Coordinator->>Node2: Prepare
    Node1-->>Coordinator: Ready
    Node2-->>Coordinator: Ready
    Coordinator->>Node1: Commit
    Coordinator->>Node2: Commit
```


### 5.4 Monitoring and Managing Distributed Systems
Monitoring and managing distributed systems are essential for maintaining system health, performance, and reliability.

#### 5.4.1 Telemetry
Telemetry is a dynamic way to track and observe system behavior. It provides metrics and insights into your system's performance.

#### Example 5.4: Using Telemetry to Monitor System Metrics
##### Step 1: Integrate Telemetry with Your Application
- Add the Telemetry library to your project.
- Set up metrics and event handlers.
##### Step 2: Monitor Specific Events
- Define events to track, such as function calls or process state changes.
- Analyze the collected data to understand system behavior.

#### Exercise 5.5: Implement Distributed System Monitoring
Description: Use tools like :observer.start to monitor nodes. Analyze communication, process states, and system health.
Hint: Explore the Observer tool's features, such as viewing load charts and processes.
Erlang Observer Tool Documentation




----------------------------------------------------------------------------
# TSBank - New Feature

## Transaction History Feature in BankAccount

## Introduction

We'll extend the BankAccount application to include a transaction history feature. This will allow users to view a history of their deposits, withdrawals, and transfers, similar to a bank statement.

### Step 1: Define a Transaction Structure

Define a structure to represent a transaction. Each transaction will have a type, amount, date, and description.
```elixir
defmodule Transaction do
  defstruct type: nil, amount: 0, date: nil, description: nil
end
```

### Step 2: Update the BankAccount State

Modify the state in the BankAccount module to include a list of transactions.

#### Initialize the State
```elixir
def init(initial_balance) do
  {:ok, %{balance: initial_balance, transactions: []}}
end
```

### Step 3: Record Transactions

Update the deposit, withdraw, and transfer functions to record transactions.

#### Example: Deposit
```elixir
def handle_cast({:deposit, amount}, %{balance: balance, transactions: transactions} = state) do
  new_balance = balance + amount
  transaction = %Transaction{type: :deposit, amount: amount, date: DateTime.utc_now(), description: "Deposit"}
  {:noreply, %{state | balance: new_balance, transactions: [transaction | transactions]}}
end
```

### Exercise 5A: Modify the withdraw and transfer functions to record transactions similarly.

### Step 4: Implement Transaction History Retrieval

Add a function to retrieve the transaction history, with optional filters.

```elixir
def transaction_history(account_number, filters \\\\ %{}) do
  GenServer.call({:via, Registry, {BankRegistry, account_number}}, {:transaction_history, filters})
end
```

### Exercise 5B: Implement the \`handle_call\` for transaction history retrieval and write a private function to apply filters.

### Step 5: Formatting and Displaying Transactions

Create a function to format the transaction history as a table or JSON.

### Exercise 5C: Write a function to format the transaction history. Look at the library Tabula.ex for inspiration.

### Step 6: Testing

Write tests for the new features.

### Exercise 5D: Write ExUnit tests to verify the transaction history feature.

### Step 7: Enhancements (Optional)

Consider implementing additional enhancements like pagination, sorting, or security controls.

### Exercise 5E: Implement one or more enhancements as described above.

## Understanding the State

State in a GenServer is a critical concept that represents the current condition of the process. It can be of any data type. In our BankAccount example, the state is a map containing the balance and a list of transactions.

### State Diagram
```mermaid
graph TD
    A[State] --> B[Balance]
    A --> C[Transactions]
    C --> D[Transaction 1]
    C --> E[Transaction 2]
    C --> F[Transaction N]
```

#### Initialize the State with Logging
```elixir
def init(initial_balance) do
  Logger.info("Initializing bank account with balance: #{initial_balance}")
  {:ok, %{balance: initial_balance, transactions: []}}
end
```

### Recording Transactions

When a deposit, withdrawal, or transfer occurs, we record a transaction. We'll update the state to include the new transaction.

### State Transition Diagram for Deposit
```mermaid
sequenceDiagram
    participant User
    participant BankAccount
    User->>BankAccount: deposit(amount)
    BankAccount->>BankAccount: Create Transaction
    BankAccount->>BankAccount: Update State
    BankAccount-->>User: Confirmation
```

#### Example: Deposit with Logging
```elixir
def handle_cast({:deposit, amount}, %{balance: balance, transactions: transactions} = state) do
  new_balance = balance + amount
  Logger.info("Depositing #{amount}. New balance: #{new_balance}")

  transaction = %Transaction{type: :deposit, amount: amount, date: DateTime.utc_now(), description: "Deposit"}
  Logger.debug("Recording transaction: #{inspect(transaction)}")

  {:noreply, %{state | balance: new_balance, transactions: [transaction | transactions]}}
end
```

### Transaction History Retrieval

When retrieving the transaction history, we can include optional filters, such as a date range or specific transaction types.

### Sequence Diagram for Transaction History Retrieval
```mermaid
sequenceDiagram
    participant User
    participant BankAccount
    User->>BankAccount: transaction_history(filters)
    BankAccount->>BankAccount: Apply Filters
    BankAccount-->>User: Filtered Transactions
```

## Conclusion

The transaction history feature provides insight into the financial activities within the BankAccount application. It demonstrates key concepts such as struct definition, state management, filtering, and formatting.

## Follow-up Questions

1.  How would you design a feature to allow users to export their transaction history as a CSV file?
2.  How could you modify the application to support different currencies and exchange rates?
3.  Discuss potential security concerns related to transaction history and propose solutions.
4.  Explain the importance of atomic operations in the context of recording transactions.
5.  How would you implement real-time notifications for transactions (e.g., using Phoenix Channels)?
