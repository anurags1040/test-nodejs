# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install app dependencies
RUN npm install

# Bundle the app source
COPY . .

# Set environment variables
ENV PORT=3000
ENV API_HOST=http://api:4000

# Expose port 3000 for the app to listen on
EXPOSE 3000

# Start the app
CMD [ "npm", "start" ]