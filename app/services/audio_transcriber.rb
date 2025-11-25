class AudioTranscriber
  require 'tempfile'

  def initialize(audio_file)
    @audio_file = audio_file
  end

  def call
    return "No audio attached" unless @audio_file.attached?

    Tempfile.create(["audio_upload", ".webm"]) do |tempfile|
      tempfile.binmode
      tempfile.write(@audio_file.download)
      tempfile.flush

      Tempfile.create(["audio_convert", ".wav"]) do |wavfile|
        wavfile_path = wavfile.path

        # Convert to WAV
        success = system(%Q(ffmpeg -y -i "#{tempfile.path}" -ar 16000 -ac 1 "#{wavfile_path}"))
        return "FFmpeg failed" unless success

        # Run whisper
        transcription = `python3 transcribe_whisper.py "#{wavfile_path}" 2>&1`
        # Run local summarization using stdin
        summary = IO.popen(
          ['python3', 'summarize_whisper.py'],
          'r+'
        ) do |io|
          io.puts transcription      # send transcript to stdin
          io.close_write
          io.read.strip           # read output from stdout
        end

        return { transcript: transcription.strip, summary: summary }
      end
    end
  end
end
