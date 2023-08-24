1. How does a Supervisor restart a process? What happens if the Supervisor itself crashes?

- In Elixir, a Supervisor is responsible for starting, monitoring, and restarting child processes. Supervisors are a fundamental part of building fault-tolerant systems in Elixir/Erlang applications. When a process being supervised crashes, the Supervisor takes action to restart it, ensuring the system's stability.

2. Describe the purpose of the Registry module in Elixir. How can it be used in managing processes?

- The Registry module in Elixir is used to associate and manage named processes, allowing you to keep track of processes by a specific name or identifier. It provides a way to create a mapping between a unique name and a process, which can be useful for various purposes, including process discovery, dynamic process management, and distributed systems.

- The primary purpose of the Registry module is to provide a way to manage and reference processes by a more meaningful name, rather than relying solely on process IDs or PIDs. This is especially useful when you want to maintain a level of abstraction between processes and their consumers, making it easier to reason about the system's behavior. 

3. Discuss the advantages and disadvantages of using a global Registry vs. a local Registry in an Elixir application.

- In Elixir applications, both global and local registries serve as tools to manage and reference processes by name, enhancing process organization and communication. However, they have different use cases, advantages, and disadvantages

**Global Registry**
**ADVANTAGES** 
- Process Discovery Across Nodes: Global registries allow you to manage processes across distributed nodes in a cluster. This is particularly useful in large-scale distributed systems where processes need to communicate across different machines.

- Centralized Naming: Processes registered in a global registry have globally unique names, making it easier to refer to them from any part of the distributed system. This can improve the clarity and maintainability of the codebase.

- Dynamic Load Balancing: In a distributed system, you can use global registries to implement dynamic load balancing by associating processes with certain tasks and distributing tasks to nodes with lower load.

**DISADVANTAGES**
- Complexity: Global registries introduce additional complexity, especially in distributed systems. You need to handle scenarios such as network partitions, node failures, and synchronization between nodes.

- Latency: Communication with processes across nodes might introduce higher latency compared to local registries, as it involves inter-node communication.

- Dependency on Distributed Systems: Using global registries might make your application more dependent on distributed systems concepts, which could lead to increased complexity and potential challenges in debugging and troubleshooting.

**LOCAL REGISTRY**
**ADVANTAGES**
- Simplicity: Local registries are simpler to work with since they are limited to the scope of a single node. There is less concern about network communication and potential distributed system issues.

- Lower Latency: Communication with processes registered in a local registry is faster, as it involves intra-node communication.

- Clearer Ownership: Local registries are typically managed by the same process that starts the child processes. This ownership can lead to better control over process lifecycles.

**DISADVANTAGES**
- Limited to Single Node: Local registries do not provide cross-node process management. If your application needs to operate in a distributed environment, you'll need to use other mechanisms for inter-node communication.

- Less Centralized Naming: While names are still unique within a node, they might not have the same level of global uniqueness as in a global registry, potentially leading to naming conflicts within the node.

- Manual Load Balancing: In local registries, you need to implement load balancing strategies manually if your application requires it.

- Overall, it is advisable to use Local Registries when you want a simpler approach to process management within a single node and don't require cross-node process management. And to use global registries when your application spans multiple nodes and you need process discovery and naming that spans the entire distributed system.


