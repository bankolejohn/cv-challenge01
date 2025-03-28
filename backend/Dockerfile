# # Use a lightweight Python image
# FROM python:3.10-slim

# # Set working directory
# WORKDIR /app

# # Set environment variables
# ENV POETRY_VERSION=1.8.2
# ENV POETRY_VIRTUALENVS_CREATE=false
# ENV PYTHONPATH=/app

# # Install Poetry
# RUN pip install "poetry==$POETRY_VERSION"

# # Copy only necessary files first (to leverage Docker caching)
# COPY pyproject.toml poetry.lock ./

# # Install dependencies
# RUN poetry install --no-root --no-interaction

# # Copy the rest of the application code
# COPY . .

# # Ensure the prestart script is executable
# RUN chmod +x /app/prestart.sh

# # Run the prestart script (for setup tasks like migrations)
# RUN /app/prestart.sh

# # Expose the backend port
# EXPOSE 8000

# # Start the FastAPI server
# # CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
# CMD ["/bin/bash", "-c", "/app/prestart.sh && poetry run uvicorn app.main:app --host 0.0.0.0 --port 8000"]


# Use a lightweight Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Set environment variables
ENV POETRY_VERSION=1.8.2
ENV POETRY_VIRTUALENVS_CREATE=false
ENV PYTHONPATH=/app

# Install Poetry
RUN pip install "poetry==$POETRY_VERSION"

# Copy only necessary files first (to leverage Docker caching)
COPY pyproject.toml poetry.lock ./

# Install dependencies
RUN poetry install --no-root --no-interaction

# Copy the rest of the application code
COPY . .

# Ensure the prestart script is executable
RUN chmod +x /app/prestart.sh

# Expose the backend port
EXPOSE 8000

# Run the prestart script at runtime, not build time
CMD ["/bin/bash", "-c", "/app/prestart.sh && poetry run uvicorn app.main:app --host 0.0.0.0 --port 8000"]
