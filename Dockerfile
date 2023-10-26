# Use an official Node.js runtime as the base image
FROM node:16

RUN mkdir /project
WORKDIR /project

RUN npm install -g @angular/cli

COPY package.json package-lock.json ./
RUN npm ci

COPY . .

# Expose the default Angular development port (4200)
EXPOSE 4200

# Start the Angular development server
CMD ["npm", "start"]