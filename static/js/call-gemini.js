
  async function sendPromptToGemini(prompt) {
    try {
      const response = await fetch('/api/gemini/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ prompt: prompt })
      });

      if (!response.ok) {
        throw new Error('API request failed');
      }

      const data = await response.json();
      console.log("Gemini API response:", data);

      // You can now use data to update the DOM, show the response, etc.
    } catch (err) {
      console.error("Error calling Gemini API:", err);
    }
  }

  // Example: Trigger with a button
  document.getElementById("ask-btn").addEventListener("click", () => {
    const userInput = document.getElementById("prompt-input").value;
    sendPromptToGemini(userInput);
  });


// <!-- Somewhere in your HTML -->
//<input type="text" id="prompt-input" placeholder="Ask Gemini something..." />
//<button id="ask-btn">Ask</button>
