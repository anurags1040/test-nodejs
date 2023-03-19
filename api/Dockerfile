FROM node:14

COPY ./bin /app/bin
COPY ./app.js /app/
COPY ./package.json /app/
WORKDIR /app
RUN npm install

EXPOSE 8080
ENV PORT=8080
ENV DBUSER=$DB_USER
ENV DBPASS=$DB_PASSWORD
ENV DB=postgres://$(DB_USER):$(DB_PASSWORD)@/private-instance-3f6dd53c?jost=/cloudsql/peak-apparatus-379619:us-central1:private-instance-3f6dd53c
ENV DBPORT=5432
# ENV DB=peak-apparatus-379619:us-central1:private-instance-3f6dd53c

ENTRYPOINT ["npm", "start"]