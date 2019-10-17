FROM node:10 as build

RUN mkdir /app
WORKDIR /app

ADD . .

RUN npm set progress=false && \
    npm config set depth 0 && \
    npm install

FROM webdevops/php-nginx:7.3 as runtime

# See https://dockerfile.readthedocs.io/en/latest/content/DockerImages/dockerfiles/php-nginx.html
ENV WEB_DOCUMENT_INDEX=index.html
ENV PHP_DISPLAY_ERRORS=1
COPY --from=build /app /app
