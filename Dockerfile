
FROM python:3.13-slim

# Copy uv binary
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Set working directory
WORKDIR /code

# Ensure venv binaries are used
ENV PATH="/code/.venv/bin:$PATH"

# Increase timeouts + enable uv cache
ENV UV_HTTP_TIMEOUT=3600
ENV UV_CACHE_DIR=/root/.cache/uv

# Copy dependency files first (for layer caching)
COPY pyproject.toml uv.lock .python-version ./

# Install dependencies
RUN uv sync --locked --no-dev

# Copy application code
COPY ingest_data.py .

# Run application
ENTRYPOINT ["python", "ingest_data.py"]
