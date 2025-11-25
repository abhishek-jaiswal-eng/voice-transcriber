class CreateTranscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :transcriptions do |t|
      t.string :audio_file
      t.text :transcription
      t.text :summary

      t.timestamps
    end
  end
end
