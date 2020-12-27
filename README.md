HTTPD4Test
=========

HTTPD4Test is a simple httpd for testing. It supports show local cotents and return message as `echo server`.

https://hub.docker.com/repository/docker/koduki/httpd4test

How to Install
----------

Install by below command. You also need `docker` in advance.

```bash
$ sudo sh -c 'curl https://raw.githubusercontent.com/koduki/httpd4test/main/cli/httpd4test > /usr/bin/httpd4test && chmod a+x /usr/bin/httpd4test'
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   186  100   186    0     0    704      0 --:--:-- --:--:-- --:--:--   704
$ httpd4test -h
Usage: httpd4test [OPTION]...
This is http server for testing
Options:
        -p, --port               port number of http server
        -m, --message            echo message
        -h, --help               this message
        --json                   change content-type to 'application/json'
```

Show local contents
----------

This is mainly used for local hosting of static contents.

```bash
$ touch a b c
$ ls -l
total 0
-rw-r--r-- 1 koduki koduki 0 Dec 26 12:17 a
-rw-r--r-- 1 koduki koduki 0 Dec 26 12:17 b
-rw-r--r-- 1 koduki koduki 0 Dec 26 12:17 c
$ httpd4test
[2020-12-26 20:17:47] INFO  WEBrick 1.7.0
[2020-12-26 20:17:47] INFO  ruby 3.0.0 (2020-12-20) [x86_64-linux]
Server is listening on :8080
Return local contents
[2020-12-26 20:17:47] INFO  WEBrick::HTTPServer#start: pid=1 port=8080
```

Confirm by web browser.
```bash
$ lynx http://localhost:8080/
                                                                 Index of /
                                Index of /

         Name        Last modified   Size
   Parent Directory 2020/12/26 20:49 -
   a                2020/12/26 20:17 0
   b                2020/12/26 20:17 0
   c                2020/12/26 20:17 0
     _____________________________________________________________

    WEBrick/1.7.0 (Ruby/3.0.0/2020-12-20) at localhost:8080
```

Run dummy API server
----------

This is mainly used for dummy API server.

```bash
$ httpd4test -p 5000 -m '{"message":"Hello World"}' --json
[2020-12-27 00:25:25] INFO  WEBrick 1.7.0
[2020-12-27 00:25:25] INFO  ruby 3.0.0 (2020-12-20) [x86_64-linux]
Server is listening on :5000
Return value is {"message":"Hello World"}
[2020-12-27 00:25:25] INFO  WEBrick::HTTPServer#start: pid=1 port=5000
```

Confrim by `curl` command
```bash
$ curl -v http://localhost:5000/
*   Trying 127.0.0.1:5000...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 5000 (#0)
> GET / HTTP/1.1
> Host: localhost:5000
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Access-Control-Allow-Origin: *
< Access-Control-Allow-Headers: X-Requested-With, Origin, X-Csrftoken, Content-Type, Accept
< Content-Type: application/json
< Server: WEBrick/1.7.0 (Ruby/3.0.0/2020-12-20)
< Date: Sun, 27 Dec 2020 00:26:55 GMT
< Content-Length: 25
< Connection: Keep-Alive
<
* Connection #0 to host localhost left intact
{"message":"Hello World"}%
```