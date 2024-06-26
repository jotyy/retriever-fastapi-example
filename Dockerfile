FROM tiangolo/uvicorn-gunicorn-fastapi:python3.10-slim-2022-11-25

ENV PYTHONUNBUFFERED=1
# ENV http_proxy=http://192.168.0.101:7890
# ENV https_proxy=http://192.168.0.101:7890

WORKDIR /code
# Install Poetry
RUN apt clean && apt update && apt install curl -y
RUN apt-get install -y libzbar-dev g++ libgl1-mesa-glx
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python && \
  cd /usr/local/bin && \
  ln -s /opt/poetry/bin/poetry && \
  poetry config virtualenvs.create false

# Copy poetry.lock* in case it doesn't exist in the repo
COPY . /code/

# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=false
RUN --mount=type=cache,target=/root/.cache bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --with dev --no-root ; else poetry install --no-root --no-dev ; fi"

ENV PYTHONPATH=/code

EXPOSE 8090

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8090"]
