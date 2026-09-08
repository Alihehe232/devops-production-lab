FROM python:3.11-slim AS builder
WORKDIR /app
RUN pip install --no-cache-dir --upgrade pip
COPY app/requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt
COPY app/ ./

FROM python:3.11-slim AS runner
WORKDIR /app
COPY --from=builder /install /usr/local
COPY --from=builder /app /app

RUN useradd -u 10001 appuser && chown -R appuser:appuser /app
USER appuser

EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')"

ENV APP_VERSION="1.4.2"
ENV COMMIT_HASH="local"
ENV ENVIRONMENT="production"

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
