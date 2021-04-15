# Nginx with Fancy Index Theme

This is an Nginx image with fancy-index module and customized version of [Fancy Index Theme](https://github.com/Naereen/Nginx-Fancyindex-Theme.git).

## Build

``` sh
docker build -t nginx-themed .
```

## Usage

Mount volume you want to see via web as `/usr/share/nginx/html-root` directory and run the image.

``` sh
docker run -v data-volume:/usr/share/nginx/html-root -p 8080:80 nginx-themed
```
