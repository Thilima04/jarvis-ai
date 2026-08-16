FROM python:3.11-slim

WORKDIR /app

# Instala dependências de sistema para OpenCV e processamento de mídia
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copia dependências e instala
COPY backend/requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia código completo da aplicação
COPY . .

# Configura PYTHONPATH para encontrar todos os módulos
ENV PYTHONPATH=/app/backend:/app:$PYTHONPATH

# Porta dinâmica injetada pelo Render/Railway
EXPOSE 8000 10000

# Executa servidor FastAPI respeitando a variável $PORT do Render
CMD ["sh", "-c", "uvicorn backend.app:app --host 0.0.0.0 --port ${PORT:-8000}"]
