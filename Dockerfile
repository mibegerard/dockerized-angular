# Stage 1: Build the Angular Application
FROM node:16 as builder

RUN mkdir /project
WORKDIR /project

# Install Angular CLI
RUN npm install -g @angular/cli

# Copy package.json and package-lock.json for dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy the source code and build the Angular application for production
COPY . .
RUN ng build --configuration=production

# Stage 2: Serve the Production Build
FROM nginx:alpine

# Copy the production build from the builder stage to the Nginx server
COPY --from=builder /project/dist/* /usr/share/nginx/html/

# Expose the default Nginx port (80)
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
