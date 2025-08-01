document.addEventListener("DOMContentLoaded", function () {
    // --- LiveClock Class ---
    class LiveClock {
        constructor(elementId, locale = undefined, options = {}) {
            this.displayElement = document.getElementById(elementId);
            this.locale = locale;
            this.options = {
                weekday: 'short',
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                timeZoneName: 'short',
                ...options // Allow overriding or adding more options
            };
            this.intervalId = null; // To store the ID returned by setInterval

            if (this.displayElement) {
                this.start();
                this.displayElement.style.wordSpacing = "5px"; // Apply styling once
            } else {
                console.warn(`LiveClock: Element with ID '${elementId}' not found.`);
            }
        }

        // Method to update the time and display it
        updateDisplay() {
            const now = new Date();
            const formattedTime = now.toLocaleTimeString(this.locale, this.options);
            this.displayElement.textContent = `Time Now: ${formattedTime}`;
        }

        // Method to start the clock (initial display and then interval)
        start() {
            // Display immediately
            this.updateDisplay();

            // Set up the interval for continuous updates
            // Use an arrow function to maintain 'this' context
            this.intervalId = setInterval(() => this.updateDisplay(), 1000);
        }

        // Optional: Method to stop the clock (useful if the element might be removed)
        stop() {
            if (this.intervalId) {
                clearInterval(this.intervalId);
                this.intervalId = null; // Clear the stored ID
                console.log(`LiveClock: Stopped updating '${this.displayElement.id}'`);
            }
        }
    }

    // --- Initialization ---
    // Create an instance of the LiveClock class
    // You can customize the locale (e.g., 'ms-MY' for Malay in Malaysia)
    // or pass in custom options if needed.
    new LiveClock("publishedDate", undefined);
    // Example for Malay in Malaysia:
    // new LiveClock("publishedDate", 'ms-MY');

    // If you had multiple elements needing live clocks:
    // new LiveClock("anotherTimeElementId", 'en-GB');
});