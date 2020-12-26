HTTPD4Test
=========

HTTPD4Test is a simple httpd for testing. It supports show local cotents and return message as `echo server`.

How to Install
----------

Install by below command. You also need `docker` in advance.

```bash
$ alias httpd4test="docker run -it -v `pwd`:/workdir -p 8080:8080 koduki/httpd4test"
$ httpd4test -h
Usage: httpd4test [OPTION]...
This is http server for testing
Options:
        -p, --port               port number of http server
        -m, --message            echo message
        -h, --help               this message
        --json           change content-type to 'application/json'
```

### DockerHub

```
https://hub.docker.com/repository/docker/koduki/httpd4test
``

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

```bash
$ lynx http://localhost:8080/

```

Run dummy API server
----------

This is mainly used for dummy API server.

```bash
$ httpd4test -m "{'message':'Hello World'}" --json
[2020-12-26 20:11:51] INFO  WEBrick 1.7.0
[2020-12-26 20:11:51] INFO  ruby 3.0.0 (2020-12-20) [x86_64-linux]
Server is listening on :8080
Return local contents
[2020-12-26 20:11:51] INFO  WEBrick::HTTPServer#start: pid=1 port=8080
```

```bash
$ curl -v http://localhost:8080/
*   Trying 127.0.0.1:8080...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 8080 (#0)
> GET / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Content-Type: application/json
< Server: WEBrick/1.7.0 (Ruby/3.0.0/2020-12-20)
< Date: Sat, 26 Dec 2020 20:16:05 GMT
< Content-Length: 25
< Connection: Keep-Alive
<
* Connection #0 to host localhost left intact
{'message':'Hello World'}
```