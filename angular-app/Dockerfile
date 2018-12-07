# FROM johnpapa/angular-cli as angular-built
# Using the above image allows us toskip the angular-cli install
FROM node:lts-alpine
WORKDIR /usr/src/app
RUN npm i -g @angular/cli
#COPY ./angular-app/package.json /usr/src/app/package.json
RUN npm install --silent
#RUN ng build --prod --build-optimizer

FROM nginx:stable-alpine
#COPY --from=angular-built /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80 443
CMD [ "nginx", "-g", "daemon off;" ]
