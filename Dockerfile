FROM quay.io/prometheus/golang-builder:1.17-base as builder
RUN go env -w GO111MODULE=on
COPY . /builddir
WORKDIR /builddir
RUN make build

FROM gcr.io/distroless/cc
COPY --from=builder /builddir/syncthing_exporter /bin/syncthing_exporter
EXPOSE 9093
ENTRYPOINT ["/bin/syncthing_exporter"]

