# Use the official Node.js image as the base image
FROM node:latest

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Update the machine
RUN apt update

# Install the dependencies
RUN npm -y install

# Copy the rest of the application code to the working directory
COPY . .

# Expose a port (e.g., 3000) on which the application will listen
EXPOSE 3000

# Specify the command to run the application
CMD ["npm", "start"]
