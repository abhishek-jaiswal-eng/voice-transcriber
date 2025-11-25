# app/controllers/transcriptions_controller.rb
class TranscriptionsController < ApplicationController
  protect_from_forgery with: :null_session

  # method to handle audio file upload and create a transcription record
  def create
    transcription = Transcription.new

    if params[:audio].present?
      transcription.audio_file.attach(params[:audio])
      # transcription.transcription = AudioTranscriber.new(transcription.audio_file).call
      transcription.save!
      render json: { message: "Audio saved", id: transcription.id }
    else
      render json: { error: "No audio uploaded" }, status: :unprocessable_entity
    end
  end

  # method to transcribe the audio file associated with a transcription record
  def transcribe
    transcription = Transcription.find(params[:id])
    result = AudioTranscriber.new(transcription.audio_file).call
    transcription.transcription = result[:transcript]
    transcription.summary = result[:summary]
    if transcription.save
      render json: { message: "Audio transcribed and Saved", id: transcription.id }
    else
      render json: { error: "Transcription failed" }, status: :unprocessable_entity
    end
  end

  def index
    @transcriptions = Transcription.all.order(created_at: :desc)
  end

  def show
    @transcription = Transcription.find(params[:id])
  end
end
