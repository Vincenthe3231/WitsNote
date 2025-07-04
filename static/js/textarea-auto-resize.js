// Function to auto-resize textarea
function autoExpandTextarea(element) {
    element.style.height = 'auto'; // Reset height to recalculate
    element.style.height = (element.scrollHeight) + 'px'; // Set height to scrollHeight
}

// Get the introduction textarea element
const introductionTextarea = document.getElementById('introductionText');

// Add event listener for input to auto-expand
if (introductionTextarea) {
    introductionTextarea.addEventListener('input', () => autoExpandTextarea(introductionTextarea));
    // Also call it once on load in case there's pre-filled content
    window.addEventListener('load', () => autoExpandTextarea(introductionTextarea));
}