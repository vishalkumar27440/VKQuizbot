FROM python:3.11-slim

# System deps required by weasyprint (PDF generation) and PyMuPDF.
RUN apt-get update && apt-get install -y --no-install-recommends \
    libc6-dev \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libcairo2 \
    libffi-dev \
    shared-mime-info \
    fonts-liberation \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN mkdir -p /app/data

# Mini App server port (only listens if MINI_APP_DOMAIN is configured / the
# miniapp component is actually started -- harmless to expose otherwise).
EXPOSE 8080

CMD ["python", "run.py"]
