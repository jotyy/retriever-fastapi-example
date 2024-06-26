from denser_retriever.retriever_general import RetrieverGeneral

retriever = RetrieverGeneral("unit_test_denser", "config.yaml")

def ingest():
    retriever.ingest("data/denser_website_passages_top10.jsonl")

def retrieve(query: str):
    return retriever.retrieve(query, {})
