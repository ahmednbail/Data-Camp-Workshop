FROM python:3.13-slim

COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

WORKDIR /code
ENV PATH="/code/.venv/bin:$PATH"

COPY pyproject.toml uv.lock .python-version ./
ENV UV_HTTP_TIMEOUT=3600
RUN uv sync --locked --no-dev

COPY ingest_data.py .
ENTRYPOINT ["python", "ingest_data.py"]
