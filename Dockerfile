FROM node:20-alpine
WORKDIR /app
COPY app/package*.json ./
RUN npm install --production
COPY app/ .
EXPOSE 3000
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1
CMD ["node", "index.js"]