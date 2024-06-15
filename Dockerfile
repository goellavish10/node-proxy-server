FROM node:18-alpine
WORKDIR /app/proxy-server
COPY package*.json ./
RUN npm install
COPY . .
ARG PORT_ARG=9000
ENV PORT=${PORT_ARG}
EXPOSE ${PORT_ARG}

CMD ["npm", "start"]
