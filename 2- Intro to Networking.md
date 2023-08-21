# Introduction to IP and Subnetting

IP (Internet Protocol) and subnetting are fundamental concepts in networking. This guide provides a comprehensive introduction to these topics, highlighting key concepts and principles.

## IP Addressing

IP addressing is a method used to identify devices on a network. There are two versions of IP addresses: IPv4 and IPv6.

### IPv4

IPv4 addresses are 32-bit numbers often represented in dotted-decimal format, such as `192.168.1.1`. They are divided into four octets, each ranging from 0 to 255.

### IPv6

IPv6 addresses are 128-bit numbers, represented in hexadecimal notation. They offer a much larger address space compared to IPv4.

## Subnetting

Subnetting is the practice of dividing an IP network into smaller networks, called subnets. It helps in efficient IP address management and network isolation.

### Subnet Masks

A subnet mask is used to identify the network portion of an IP address. It's often represented in the same format as an IPv4 address. For example, a subnet mask of `255.255.255.0` corresponds to a `/24` prefix length.

### CIDR Notation

CIDR (Classless Inter-Domain Routing) notation is a shorthand way to describe subnet masks. For example, `192.168.1.0/24` represents the `192.168.1.0` network with a 24-bit subnet mask.

### Subnetting Techniques

Subnetting can be done manually or with the help of subnet calculators. It involves:

- Determining the number of required subnets and hosts per subnet
- Calculating the subnet mask
- Identifying the range of IP addresses for each subnet

## Further Resources

Please read the following pdf and look at the Video series:

- [Intro IP Networking](https://www.ics.uci.edu/~magda/ics_x33/ch0.pdf)
- [IP Video Tutorial](https://www.youtube.com/playlist?list=PLIhvC56v63IKrRHh3gvZZBAGvsvOhwrRF)

## Conclusion

Understanding IP and subnetting is essential for network professionals. 
