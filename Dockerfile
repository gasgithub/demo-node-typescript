#FROM registry.access.redhat.com/ubi8/nodejs-12:1-52 AS builder
#FROM registry.access.redhat.com/ubi8/nodejs-12:latest AS builder
FROM us.icr.io/gas-registry/nodejs-12:latest AS builder

USER 0
RUN yum install -y python38

USER 1001
WORKDIR /opt/app-root/src

COPY . .

RUN ls -lA && npm install
RUN npm run build

#FROM registry.access.redhat.com/ubi8/nodejs-12:1-52
#FROM registry.access.redhat.com/ubi8/nodejs-12:latest
FROM us.icr.io/gas-registry/nodejs-12:latest AS builder
#USER 0
#RUN yum update -y
#USER 1001

COPY --from=builder /opt/app-root/src/dist dist
COPY --from=builder /opt/app-root/src/public public
COPY --from=builder /opt/app-root/src/package.json .
RUN npm install --production

ENV HOST=0.0.0.0 PORT=3000

EXPOSE 3000/tcp

CMD npm run serve
