FROM koki/sbmfcv_component:latest

ADD src /src
ADD sbmfcv /
ADD Snakefile /

WORKDIR /

ENTRYPOINT ["/sbmfcv"]
