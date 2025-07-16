// Get the introduction textarea element
const introductionTextarea = document.getElementById('introductionText');
const blogPostTitle = document.getElementById('blogPostTitle');
// const textareas = document.querySelectorAll('textarea.form-control-plaintext');

// Function to auto-resize textarea
function autoExpandTextarea(element) {
    element.style.height = 'auto'; // Reset height to recalculate
    element.style.height = (element.scrollHeight) + 'px'; // Set height to scrollHeight
}

// Add event listener for input to auto-expand
if (introductionTextarea) {
    introductionTextarea.addEventListener('input', () => autoExpandTextarea(introductionTextarea));
    // Also call it once on load in case there's pre-filled content
    window.addEventListener('load', () => autoExpandTextarea(introductionTextarea));
}

// Add event listener for input to auto-expand
if (blogPostTitle) {
    blogPostTitle.addEventListener('input', () => autoExpandTextarea(blogPostTitle));
    // Also call it once on load in case there's pre-filled content
    window.addEventListener('load', () => autoExpandTextarea(blogPostTitle));
}

document.addEventListener('DOMContentLoaded', function() {
    // Select all textareas you want to apply this to
    const textareas = document.querySelectorAll('textarea.form-control-plaintext');

    textareas.forEach(textarea => {
        textarea.addEventListener('keydown', function(e) {
            // Check if the pressed key is the Tab key (keyCode 9 or key 'Tab')
            if (e.key === 'Tab' || e.keyCode === 9) {
                e.preventDefault(); // Prevent the default tab behavior (moving focus)

                const start = this.selectionStart;
                const end = this.selectionEnd;
                const value = this.value;

                // Determine the indentation string (e.g., 4 spaces or a tab character)
                // You can change this to '    ' (4 spaces) if you prefer spaces over actual tab characters
                const indent = '        '; // Using 4 spaces for indentation

                // Insert the indentation string at the current cursor position or selection
                this.value = value.substring(0, start) + indent + value.substring(end);

                // Move the cursor to the end of the inserted indentation
                this.selectionStart = this.selectionEnd = start + indent.length;
            }
        });
    });
});