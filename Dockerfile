FROM nginx as builder

RUN apt-get update && apt-get -y install git build-essential curl libpcre3-dev libssl-dev libz-dev && rm -rf /var/lib/apt/lists/*
WORKDIR /build
RUN curl -O http://nginx.org/download/nginx-1.19.10.tar.gz && \
    tar xaf nginx-1.19.10.tar.gz && \
    git clone https://github.com/aperezdc/ngx-fancyindex.git && \
    cd nginx-1.19.10 && \
    nginx -V 2>&1| egrep '^configure arguments: ' | sed -e 's/^configure arguments: //' > nginx.flags && \
    sh -c "./configure $(cat nginx.flags) --add-dynamic-module=../ngx-fancyindex" && \
    make

FROM nginx
    MAINTAINER Alexander Koptelov <alexandre.koptelov@gmail.com>

COPY --from=builder /build/nginx-1.19.10/objs/ngx_http_fancyindex_module.so /etc/nginx/modules
COPY 10-ngx_http_fancyindex_module.conf /etc/nginx/modules/
COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/
COPY Nginx-Fancyindex-Theme-dark /usr/share/nginx/themes/Nginx-Fancyindex-Theme-dark
