import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.mediaRecorder = null
    this.chunks = []
  }

  async start() {
    if (!navigator.mediaDevices) {
      alert("Your browser does not support audio recording")
      return
    }

    const stream = await navigator.mediaDevices.getUserMedia({ audio: true })
    this.mediaRecorder = new MediaRecorder(stream)

    this.mediaRecorder.ondataavailable = (e) => {
      this.chunks.push(e.data)
    }

    this.mediaRecorder.start()
    console.log("Recording started")
  }

  stop() {
    if (!this.mediaRecorder) return

    this.mediaRecorder.onstop = async () => {
      const blob = new Blob(this.chunks, { type: "audio/webm" })
      this.chunks = []

      const formData = new FormData()
      formData.append("audio", blob)

      const response = await fetch("/transcriptions", {
        method: "POST",
        body: formData,
        headers: { "Accept": "application/json" }
      })

      const data = await response.json()
      console.log(data) // shows saved record ID

      const transcribeResponse = await fetch('/transcribe', {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: JSON.stringify({ id: data.id })
      })
      .then(response => response.json())
      .then(data => {
        console.log("Success:", data);
        alert(`Audio saved and Transcribed with ID: ${data.id}`)
        window.location.reload();   // Reload page
      })
      .catch((error) => {
        console.error("Error:", error);
      });
      
    }

    this.mediaRecorder.stop()
    console.log("Recording stopped")
  }
}
