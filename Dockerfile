# Stage 0, "build-stage", based on Node.js, to build and compile Angular
FROM node:lts-alpine as build-stage
ARG NODE_ENV=devprod

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

#Angular CLI
RUN npm install -g @angular/cli@8.2.1

# Create a directory where our app will be placed. This might not be necessary
RUN mkdir -p /ma_web

WORKDIR /ma_web

COPY package*.json /ma_web/

RUN npm install

COPY . /ma_web

RUN echo $NODE_ENV
# RUN ng build --prod=true  --build-optimizer=false  --output-path=./dist/
# RUN ng build --prod=true --build-optimizer=false -c dev --output-path=./dist/
RUN ng build --prod=true --build-optimizer=false --vendor-chunk=true -c ${NODE_ENV} --output-hashing=all --output-path=./dist/
# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.16.0-alpine

COPY --from=build-stage /ma_web/dist/ /usr/share/nginx/html

COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf

#RUN ng build --prod=true -c production --output-path=./dist/