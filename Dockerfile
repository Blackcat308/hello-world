FROM node:16.13.0 AS build

WORKDIR /hello

COPY ./ /hello/

RUN npm i --registry https://registry.npm.taobao.org

RUN npm run build

FROM nginx:1.16.0

WORKDIR /data

COPY --from=build /hello/dist /data

RUN rm /etc/nginx/conf.d/default.conf

ADD hello.conf /etc/nginx/conf.d/default.conf

RUN /bin/bash -c 'echo init ok'