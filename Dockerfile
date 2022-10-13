FROM golang:1.19.1-buster as go-target
ADD . /miller
WORKDIR /miller/cmd/mlr
RUN go build

FROM golang:1.19.1-buster
COPY --from=go-target /miller/cmd/mlr/mlr /
COPY --from=go-target /miller/test/input/*.csv /testsuite/

ENTRYPOINT []
CMD ["/mlr", "--csv", "sort", "-f", "shape", "@@"]
