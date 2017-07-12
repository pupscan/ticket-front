FROM node:latest
MAINTAINER thibaut.mottet@pupscan.fr

RUN npm install -g http-server

WORKDIR /workspace
COPY . .
RUN npm install
RUN npm run build

EXPOSE 8080

CMD http-server /workspace/dist
