# Socket Programming

## What's a socket ?
An endpoint for communication or an Interprocess communication(IPC) method or where two parts can fit (2 way communication) (or in unix a file descripter indeed).

A file descripter ? 
Create a socket (with socket() system call)
Get the PID (getpid() system call)
Put some wait with any input
Run the command - 

Linux:
``` 
/proc/<PID>/fd 
```
Mac:
```
ls -p <PID>
```

## Types of Socket
2 main sockets used in communication are "SOCK_STREAM” and “SOCK_DGRAM" or "Stream socket" and "Datagram Socket".

1. Stream Sockets :- Reliable , Data reaches in sequence in which sent, error-free. Uses TCP. 
Ex.-
- Browsers uses HTTP and HTTP uses Stream socket 
- telnet or ssh applications

2. Datagram Sockets :- Connectionsless ? Data Might reach , might not. When all data reaching is not necessary (like video calls, some live streams). Uses UDP.

Why Datagrams ? Speed, Faster than stream socket. fire-and-forget.

Ex.-
- Games , video conferencing etc.
- **Some file transfer protocols like tftp**
- **dhcpcd (a DHCP client)**


Wait ? but the last 2 require no data loss ?

Sends the package until it gets acknowledge of recieving in every 5 sec or some time interval.

