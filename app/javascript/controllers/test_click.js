document.addEventListener("DOMContentLoaded", () => {
  const startBtn = document.getElementById("start-btn")
  const stopBtn = document.getElementById("stop-btn")

  startBtn?.addEventListener("click", () => {
    alert("Start button clicked!")
  })

  stopBtn?.addEventListener("click", () => {
    alert("Stop button clicked!")
  })
})
