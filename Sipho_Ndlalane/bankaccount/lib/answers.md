## 1. How does a Supervisor restart a process? What happens if the Supervisor itself crashes?

- When a supervised process crashes, the supervisor restarts the process and also define a restart stratey for its child process.

- Elixir has a Supervisor hierarchy that can restart a Superviser if it crashes.

## 2. Describe the purpose of the Registry module in Elixir. How can it be used in managing processes?

- Registry module is used to manage named processes and associated with it in a distributed Elixir system.

- It can be used by starting a process, then you can register that process using the registry modulle which you can be able to use the process on a later stage.  

## 3. Discuss the advantages and disadvantages of using a global Registry vs. a local Registry in an Elixir application.

# Advantages of Global Registry

- Allows processes to be registered and managed across nodes in a distributed cluster. 

-  You can provide a central naming mechanism for processes.

- Helps maintain process registration even if individual nodes fail.

# Disadvantages of Global Registry

- Using a global Registry can add latency and potential bottlenecks due to network communication.

# Advantages of Lobal Registry

- Local Registry operates within a single node, minimizing network communication. 

- Better performance and lower latency for process interactions.

- If a node crashes, it doesn't impact the local registries on other nodes.

# Disadvantages of Lobal Registry

- Local Registry instances are isolated to individual nodes, which can make it more challenging to manage processes that need to interact across nodes.

- Naming conflicts if you using the same name for a process.