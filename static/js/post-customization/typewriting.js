document.addEventListener('DOMContentLoaded', function () {
    // Select all textareas with the blog post class
    const textareas = document.querySelectorAll('textarea.form-control-plaintext');

    // Function to auto-resize a textarea
    function autoExpandTextarea(textarea) {
        textarea.style.height = 'auto'; // Reset
        textarea.style.height = textarea.scrollHeight + 'px'; // Adjust
    }

    // Attach handlers to each textarea
    textareas.forEach(textarea => {
        // Auto-expand on input
        textarea.addEventListener('input', () => autoExpandTextarea(textarea));

        // Auto-expand immediately in case of prefilled content
        autoExpandTextarea(textarea);

        // Enable tab indentation
        textarea.addEventListener('keydown', function (e) {
            if (e.key === 'Tab' || e.keyCode === 9) {
                e.preventDefault();

                const start = this.selectionStart;
                const end = this.selectionEnd;
                const indent = '        '; // 8 spaces

                // Insert indentation
                this.value = this.value.substring(0, start) + indent + this.value.substring(end);
                this.selectionStart = this.selectionEnd = start + indent.length;

                // Expand after inserting
                autoExpandTextarea(this);
            }
        });
    });
});
