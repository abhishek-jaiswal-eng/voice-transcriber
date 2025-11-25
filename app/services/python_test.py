from transformers import pipeline

summarizer = pipeline("summarization", model="sshleifer/distilbart-cnn-12-6")
print(summarizer("This is a test transcript. Summarize it.", max_length=50, min_length=10))
