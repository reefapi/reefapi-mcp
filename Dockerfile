FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY server.py .
# stdio by default; set MCP_TRANSPORT=streamable-http to serve over HTTP (port 8000)
ENV MCP_TRANSPORT=stdio
CMD ["python", "server.py"]
