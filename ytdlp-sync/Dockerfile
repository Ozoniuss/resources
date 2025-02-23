FROM alpine:3.14

ENV YT_DLP_VERSION=2025.02.19

RUN apk add --no-cache --upgrade ffmpeg bash curl jq 

RUN curl --fail -L "https://github.com/yt-dlp/yt-dlp/releases/download/${YT_DLP_VERSION}/yt-dlp_linux" -o /usr/local/bin/yt-dlp \
    && chmod +x /usr/local/bin/yt-dlp

COPY download.sh /download.sh