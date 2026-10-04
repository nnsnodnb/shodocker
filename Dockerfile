# Build stage
FROM python:3.13.5 AS builder

ARG SHODO_PYTHON_VERSION=1.1.0

RUN pip install -U pip
RUN pip install shodo=="${SHODO_PYTHON_VERSION}" --target /__pypackages__

# Runtime stage
FROM gcr.io/distroless/python3:nonroot

COPY --from=builder /__pypackages__ /__pypackages__

ENV PYTHONPATH=/__pypackages__
ENV XDG_CONFIG_HOME=/

WORKDIR /shodo

ENTRYPOINT ["python", "/__pypackages__/bin/shodo"]
