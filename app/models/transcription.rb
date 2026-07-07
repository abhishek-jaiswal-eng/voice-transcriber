class Transcription < ApplicationRecord
  has_one_attached :audio_file
  has_ones :transcription_text
end
