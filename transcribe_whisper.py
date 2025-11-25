import sys
import warnings
warnings.filterwarnings("ignore") 

import whisper

# Load model once
model = whisper.load_model("base")

# Audio file path passed from Rails
audio_file = sys.argv[1]

result = model.transcribe(audio_file)
print(result['text'])
