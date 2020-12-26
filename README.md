HTTPD4Test
=========

HTTPD4Test is a simple httpd for testing. It supports show local cotents and return message as `echo server`.

How to use
----------

```bash
$ alias httpd4test="docker run -it -p 8080:8080 koduki/httpd4test"
$ httpd4test -h
Usage: httpd4test [OPTION]...
This is http server for testing
Options:
        -p, --port               port number of http server
        -m, --message            echo message
        -h, --help               this message
        --json           change content-type to 'application/json'
```