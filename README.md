# **Docker-Firefox**

Dockerfile for building Mozilla Firefox image.

## **Usage**

Build Docker image as follows:
```console
docker build -t firefox .
```

Use the following command to run:
```console
docker run --net=host -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/firefox/hostdir:$HOME firefox
```

## **Author**

[Saad Ali](https://github.com/nixknight)
