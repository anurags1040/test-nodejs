FROM node:14

COPY ./bin /app/bin
COPY ./app.js /app/
COPY ./package.json /app/
WORKDIR /app
RUN npm install

EXPOSE 8080
ENV PORT=8080
ENV DB=postgres://$(username):$(password)@/private-instance-3f6dd53c?jost=/cloudsql/peak-apparatus-379619:us-central1:private-instance-3f6dd53c
ENV DBUSER=$DB_USER
ENV DBPASS=$DB_PASSWORD
ENV DBPORT=5432
# ENV DB=peak-apparatus-379619:us-central1:private-instance-3f6dd53c

ENTRYPOINT ["npm", "start"]