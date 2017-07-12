FROM node:latest
MAINTAINER thibaut.mottet@pupscan.fr

WORKDIR /workspace
COPY . .
RUN npm install
RUN npm run build

EXPOSE 8080

CMD [ "npm run start" ]
