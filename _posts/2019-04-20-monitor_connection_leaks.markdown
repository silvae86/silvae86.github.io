---
layout: post
title:  "How to monitor connection leaks"
date:   2019-04-20 21:44:00 +0100
categories: connection leaks monitoring
---

Database connections need to be managed properly. If we keep opening connections to a database without closing or releasing them (in the case of a connection pool), the database will soon stop responding.

Another issue that you may face is that many databases use sockets to communicate with their clients. If you keep opening connections without closing them, you may face `EMFILE: Too many open files` errors. After all, the sockets are file descriptors that the client will hold on to.

## Monitoring the file descriptors held by a process running on a certain port

This command will print you the list of open file descriptors (thus including sockets) that a program on a certain port (in this case `1111`) is holding on to.

{% highlight shell %}
watch -n 1 'lsof -i -n -P | grep 1111 | grep CLOSE_WAIT | wc -l'
{% endhighlight %}

1. uses `watch -n 1` to continuously run the command that comes next. In this case, we are using a command that contains pipes (`|`), so we must put the entire command inside quotes.
2. Gets the list of file descriptors currently open, with the open ports  of the processes who are holding them: `lsof -i -n -P`
3. Filters only the file descriptors held by a process listening in a certain port (`grep 1111`) for the processes listening on port `1111`
4. Filters the file descriptors where the server has already closed the connection but the client is still holding on to objects (i.e. has not closed the connection on its side).
5. counts the number of lines in an output, with `wc -l`. In this case, since the previous command prints one line of text per open file descriptor, it will give us the number of descriptors that correspond to our restrictions, as specified by the two `grep` pipes.
