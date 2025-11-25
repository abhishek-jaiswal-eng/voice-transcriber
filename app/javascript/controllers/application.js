import { Application } from "@hotwired/stimulus"
import TranscriptionController from "./transcription_controller"

const application = Application.start()
application.register("transcription", TranscriptionController)


// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
