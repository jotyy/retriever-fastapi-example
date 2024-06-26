from fastapi import FastAPI
from pydantic import BaseModel

from retriever.api import ingest, retrieve

app = FastAPI()


class Query(BaseModel):
    question: str


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/retrieve")
def retrive(query: Query):
    passages, docs = retrieve(query.question)
    return {"passages": passages, "docs": docs}

ingest()
