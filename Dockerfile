FROM alpine:3.19 AS builder

ARG VERSION="2024.4.1"

ARG URL="https://github.com/cloudflare/cloudflared/releases/download/${VERSION}/cloudflared-linux-arm64"

RUN apk update && apk add curl && curl -L ${URL} -o cloudflared
  
FROM alpine:3.15

WORKDIR /usr/local/bin

COPY --from=builder cloudflared . 
RUN chmod +x cloudflared

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
