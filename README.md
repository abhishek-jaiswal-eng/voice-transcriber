# Audio Transcriber using RoR

This project is an **Audio Transcription and Summarization System** built with **Ruby on Rails** and integrated with a **local Python-based transcription and summarization system** using Whisper and NLTK/Sumy.

The system allows uploading audio recordings, transcribing them to text, and generating a summary of the transcript.

Important Note: 
1. No Live Transcription is added into this project as it required live keys
2. Summary can be same as the Transcribed data if Data is too small.
---
## **Technology used**

1. Ruby on Rails
2. Ruby 3.2.3
3. Rails 7.1.6
4. OpenAI-Whisper local library
5. Sumy + NLTK
6. Python3

## **Features**

1. **Audio Transcription**
   - Upload audio files (supported formats: `.webm`, `.wav`).
   - Transcription done locally using OpenAI Whisper model in Python.
   - Avoids sending audio to external APIs.

2. **Audio Summary**
   - Summarizes the transcript locally using either:
     - Extractive summarization (`Sumy` + NLTK)  
     - Optionally, Transformers models for abstractive summarization (if environment allows)
   - Fully local and secure.

3. **Rails Integration**
   - Audio files are stored temporarily in `tmp` for processing.
   - Transcription and summary returned via Rails service.
   - API routes:
     - `summary/:id` → returns transcript and summary for a given audio file record.

---

## **Installation Steps**

### **1. Clone the repository**
```bash
git clone https://github.com/abhishek-jaiswal-eng/voice-transcriber.git
cd voice-transcriber
```

### **2. Install Rails Dependencies**
```bash
bundle install
```
### **3. Setup DB**
```bash
rails db:create
rails db:migrate
```
### **4. Install Python3 Dependencies**
#### Ensure you have Python 3.10+ installed.
```bash
python3 -m pip install --upgrade pip
python3 -m pip install torch
python3 -m pip install openai-whisper
python3 -m pip install nltk sumy
```

#### Download NLTK punkt tokenizer for Sumy:
```bash
python3 -m nltk.downloader punkt
```

### **5. Start server**
```bash
rails s
```

---

## **How to Use IT**

### 1. Visit `/transcribe`
### 2. Click on  `Start Recording` to record
### 3. Provide access to microphone
### 4. Once done recording, click `Stop recording` to stop the recording.
### 5. Wait for few seconds and after alert is shown, The page will be refreshed with recordings made.
### 6. Click on any recording to visit `/summary/:id` page and listen to recording or see the transcrript or see the summary. 

---

## **Author**

**Abhishek Jaiswal**  
GitHub: [abhishek-jaiswal-eng](https://github.com/abhishek-jaiswal-eng)  
Feel free to reach out for any queries or contributions!