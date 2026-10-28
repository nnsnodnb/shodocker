# Build stage
FROM debian:trixie-slim AS builder

COPY --from=ghcr.io/astral-sh/uv:0.13.6 /uv /usr/local/bin/uv

ENV UV_PYTHON_INSTALL_DIR=/opt/python \
    UV_PYTHON_PREFERENCE=only-managed \
    UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1

WORKDIR /app

RUN uv python install 3.15.2 \
 && uv venv /app/.venv --python 3.15.2 \
 && PY="$(echo /opt/python/cpython-3.15.2-*)" \
 && test -d "${PY}" \
 && rm -rf "${PY}"/lib/python3.15/site-packages/pip \
           "${PY}"/lib/python3.15/site-packages/pip-*.dist-info \
           "${PY}"/lib/python3.15/ensurepip

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev --no-install-project

# Runtime stage
FROM gcr.io/distroless/cc-debian13:nonroot

COPY --from=builder /opt/python /opt/python
COPY --from=builder /app/.venv /app/.venv

ENV PYTHONUNBUFFERED=1\
    XDG_CONFIG_HOME=/

WORKDIR /shodo

ENTRYPOINT ["/app/.venv/bin/shodo"]
