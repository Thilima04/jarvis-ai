FROM python:3.11-slim

WORKDIR /app

# Instala dependências de sistema para OpenCV e processamento de mídia no Debian moderno
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

# Variáveis de ambiente padrão
ENV PORT=8000
ENV HOST=0.0.0.0

EXPOSE 8000

# Executa servidor FastAPI
CMD ["uvicorn", "backend.app:app", "--host", "0.0.0.0", "--port", "8000"]
