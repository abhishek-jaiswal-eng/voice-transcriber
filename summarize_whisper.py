import sys
import nltk
from sumy.parsers.plaintext import PlaintextParser
from sumy.nlp.tokenizers import Tokenizer
from sumy.summarizers.lex_rank import LexRankSummarizer

# Download punkt if not present
nltk.download("punkt")
nltk.download('punkt_tab')

transcript = sys.stdin.read()

parser = PlaintextParser.from_string(transcript, Tokenizer("english"))
summarizer = LexRankSummarizer()
summary_sentences = summarizer(parser.document, sentences_count=min(3, len(parser.document.sentences)))

summary = " ".join(str(s) for s in summary_sentences)
print(summary)
