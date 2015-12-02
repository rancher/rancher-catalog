FROM rancher/dind:v0.6.0

ADD ./scripts/bootstrap /scripts/bootstrap
RUN /scripts/bootstrap
