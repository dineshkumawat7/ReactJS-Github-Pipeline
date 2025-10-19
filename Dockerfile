# =========================================
# Stage 1: Build the React.js Application
# =========================================
FROM node:22-alpine AS dist

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build 

# =========================================
# Stage 2: Serve with Nginx
# =========================================
FROM nginx:stable-alpine

COPY --from=dist /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
