FROM koki/sbmf_component:latest

ADD src /src
ADD sbmf /
ADD Snakefile /

WORKDIR /

ENTRYPOINT ["/sbmf"]
