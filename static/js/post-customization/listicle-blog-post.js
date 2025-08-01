document.addEventListener("DOMContentLoaded", function () {
    // --- Typewriter Effect Class ---
    class Typewriter {
        constructor(elementId, text, speed) {
            this.writer = document.getElementById(elementId);
            this.text = text;
            this.speed = speed;
            this.i = 0;

            if (this.writer) {
                this.type();
            }
        }

        type() {
            if (this.i < this.text.length) {
                this.writer.textContent += this.text.charAt(this.i++);
                requestAnimationFrame(() => this.type());
            }
        }
    }

    // --- Image Modal Class ---
    class ImageModal {
        constructor(modalElementId, previewImageId) {
            this.modalElement = document.getElementById(modalElementId);
            this.modalPreviewImage = document.getElementById(previewImageId);
            this.bootstrapModal = new bootstrap.Modal(this.modalElement);
            this.currentZoom = 1;

            this.addEventListeners();
        }

        addEventListeners() {
            this.modalPreviewImage.addEventListener("wheel", (e) => this.handleWheel(e));
            this.modalElement.addEventListener("hidden.bs.modal", () => this.resetModal());
        }

        handleWheel(e) {
            e.preventDefault();
            this.currentZoom += (e.deltaY < 0 ? 0.1 : -0.1);
            this.currentZoom = Math.max(0.5, Math.min(5, this.currentZoom));
            this.modalPreviewImage.style.transform = `scale(${this.currentZoom})`;
        }

        resetModal() {
            this.currentZoom = 1;
            this.modalPreviewImage.style.transform = "scale(1)";
        }

        show(imageSrc) {
            this.modalPreviewImage.src = imageSrc;
            this.resetModal(); // Ensure reset when a new image is shown
            this.bootstrapModal.show();
        }
    }

    // --- Image Upload/Preview Class ---
    class ImageUploader {
        constructor(sectionElement, imageModalInstance) {
            this.section = sectionElement;
            this.plusIcon = this.section.querySelector(".bi-plus");
            this.fileInput = this.section.querySelector("input[type='file']");
            this.container = this.section.querySelector(".imageContainer");
            this.imageModal = imageModalInstance; // Dependency Injection

            this.addEventListeners();
        }

        addEventListeners() {
            this.plusIcon.addEventListener("click", () => this.fileInput.click());
            this.fileInput.addEventListener("change", (e) => this.handleFileChange(e));
        }

        handleFileChange(e) {
            [...e.target.files].forEach(file => {
                if (!file.type.startsWith("image/")) return;

                const reader = new FileReader();
                reader.onload = (ev) => this.createImagePreview(ev.target.result);
                reader.readAsDataURL(file);
            });
            // The original code had fileInput.value = ''; commented out.
            // If you want to clear the input after selection, uncomment the next line:
            // this.fileInput.value = '';
        }

        createImagePreview(src) {
            const wrapper = document.createElement("div");
            wrapper.className = "position-relative";

            const img = document.createElement("img");
            img.src = src;
            img.className = "img-thumbnail";
            img.style.maxWidth = "150px";
            img.style.cursor = "pointer";
            img.addEventListener("click", () => this.imageModal.show(img.src));

            const removeBtn = document.createElement("button");
            removeBtn.innerHTML = "&times;";
            removeBtn.className = "btn btn-sm btn-danger position-absolute top-0 end-0";
            removeBtn.style.transform = "translate(50%, -50%)";
            removeBtn.addEventListener("click", () => wrapper.remove());

            wrapper.appendChild(img);
            wrapper.appendChild(removeBtn);
            this.container.appendChild(wrapper);
        }
    }

    // Subheading Manager
    class SubHeadingManager {
        constructor(addButtonId, containerId) {
            this.addBtn = document.getElementById(addButtonId);
            this.container = document.getElementById(containerId);
            this.counter = 0;

            if (this.addBtn && this.container) {
                this.addBtn.addEventListener("click", () => this.addSubHeading());
            }
        }

        addSubHeading(focus = true) {
            const wrapper = document.createElement("div");
            wrapper.className = "position-relative d-flex flex-column gap-2";

            // Subheading textarea
            const subTextarea = document.createElement("textarea");
            subTextarea.name = `sub_heading_${this.counter}`;
            subTextarea.className = "form-control-subheading";
            subTextarea.rows = 1;
            subTextarea.placeholder = "Enter subheading or listicle point...";
            subTextarea.required = true;

            // Content textarea
            const contentTextarea = document.createElement("textarea");
            contentTextarea.name = `sub_content_${this.counter++}`;
            contentTextarea.className = "form-control-subcontent";
            contentTextarea.rows = 2;
            contentTextarea.placeholder = `Enter detailed content for the subheading... \n        "Shift + Enter" for new line`;
            contentTextarea.required = true;

            // Remove button
            const removeBtn = document.createElement("button");
            removeBtn.innerHTML = "&times;";
            removeBtn.className = "btn btn-sm btn-danger position-absolute top-0 end-0";
            removeBtn.style.transform = "translate(50%, -50%)";
            removeBtn.addEventListener("click", () => wrapper.remove());

            wrapper.appendChild(subTextarea);
            wrapper.appendChild(contentTextarea);
            wrapper.appendChild(removeBtn);
            this.container.appendChild(wrapper);

            // Enable features
            this.enableAutoFeatures(subTextarea);
            this.enableAutoFeatures(contentTextarea);

            if (focus) {
                subTextarea.focus();
            }
        }

        enableAutoFeatures(textarea) {
            const autoExpand = () => {
                textarea.style.height = 'auto';
                textarea.style.height = textarea.scrollHeight + 'px';
            };

            textarea.addEventListener('input', autoExpand);
            autoExpand();

            textarea.addEventListener('keydown', (e) => {
                // TAB: Insert 8-space indent
                if (e.key === 'Tab') {
                    e.preventDefault();
                    const start = textarea.selectionStart;
                    const end = textarea.selectionEnd;
                    const indent = '        ';
                    textarea.value = textarea.value.substring(0, start) + indent + textarea.value.substring(end);
                    textarea.selectionStart = textarea.selectionEnd = start + indent.length;
                    autoExpand();
                }

                // ESC: Remove current textarea and its wrapper
                if (e.key === 'Escape') {
                    e.preventDefault();
                    const wrapper = textarea.closest(".position-relative");
                    if (wrapper) {
                        wrapper.remove();
                    }
                }

                if (e.key === 'Enter' && !e.shiftKey) {
                    e.preventDefault();

                    // Only add new subheading if we're in a subheading textarea (not content)
                    if (textarea.classList.contains("form-control-subheading")) {
                        this.addSubHeading();
                    }

                    // Focus the newly added textarea
                    const allTextareas = this.container.querySelectorAll('textarea');
                    if (allTextareas.length > 0) {
                        allTextareas[allTextareas.length - 1].focus();
                    }
                }
            });
        }

        // class AddTextArea

    }


    // --- Initialization ---
    // Initialize the Typewriter Effect
    const text = "You can organize your contents with the aid of headings, subheadings, and bullet points.";
    new Typewriter("typewriter", text, 40);

    // Initialize the Image Modal
    const imagePreviewModal = new ImageModal("imagePreviewModal", "modalPreviewImage");

    // Initialize Image Uploaders for each section
    document.querySelectorAll("section[data-section]").forEach(section => {
        new ImageUploader(section, imagePreviewModal);
    });

    // Initialize SubheadingManager for main content section
    new SubHeadingManager("addSubHeadingBtn", "subHeadingContainer");
});