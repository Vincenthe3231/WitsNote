document.addEventListener('DOMContentLoaded', function () {
    // Select all textareas with either 'form-control-plaintext' or 'form-control' class
    const textareas = document.querySelectorAll('textarea.form-control-plaintext, textarea.form-control-subheading, textarea.form-control');

    // Function to auto-resize a textarea
    function autoExpandTextarea(textarea) {
        textarea.style.height = 'auto'; // Reset height
        textarea.style.height = textarea.scrollHeight + 'px'; // Set to scroll height
    }

    // Attach handlers to each textarea
    textareas.forEach(textarea => {
        // Auto-expand on input
        textarea.addEventListener('input', () => autoExpandTextarea(textarea));

        // Auto-expand immediately on page load in case of prefilled content
        autoExpandTextarea(textarea);

        // Enable tab indentation
        textarea.addEventListener('keydown', function (e) {
            if (e.key === 'Tab' || e.keyCode === 9) {
                e.preventDefault();

                const start = this.selectionStart;
                const end = this.selectionEnd;
                const indent = '        '; // 8 spaces

                // Insert indentation at caret position
                this.value = this.value.substring(0, start) + indent + this.value.substring(end);
                this.selectionStart = this.selectionEnd = start + indent.length;

                // Adjust height after inserting indent
                autoExpandTextarea(this);
            }

            // Handle Enter key: auto-expand after inserting newline
            if (e.key === 'Enter' || e.keyCode === 13) {
                // Let the browser insert the newline, then adjust the height shortly after
                requestAnimationFrame(() => autoExpandTextarea(this));
            }
        });
    });
});
