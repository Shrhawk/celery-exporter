FROM arm64v8/python:3.9.1

EXPOSE 9808

RUN apt-get update && apt-get install -y locales libcurl4-openssl-dev libssl-dev \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /app/
RUN python -m pip install --upgrade pip
RUN pip install poetry==1.1.4
COPY pyproject.toml poetry.lock /app/
RUN poetry config virtualenvs.create false && poetry add scons && poetry install --no-interaction #!COMMIT

ENV PYTHONUNBUFFERED 1

COPY . /app/

ENTRYPOINT ["python", "/app/cli.py"]
