# =========================================
# Stage 1: Build the React.js Application
# =========================================

# Use the official Node.js runtime as the base image
FROM node:22-alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire application code to the container
COPY . .

# Build the React app
RUN npm run build 

# =========================================
# Stage 2: Serve with Nginx
# =========================================

# Use Nginx as the production server
FROM nginx:stable-alpine

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy build output from the first stage
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
