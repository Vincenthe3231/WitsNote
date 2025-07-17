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

    // --- Initialization ---
    // Initialize the Typewriter Effect
    const typewriterText = "This is the Standard Blog Post template. The template is designed to help you create a well-structured yet simple-and-clean blog post, allowing you to share your sudden inspiration, ideas, and insights with your audience real quick without extra efforts.";
    new Typewriter("typewriter", typewriterText, 40);

    // Initialize the Image Modal
    const imagePreviewModal = new ImageModal("imagePreviewModal", "modalPreviewImage");

    // Initialize Image Uploaders for each section
    document.querySelectorAll("section[data-section]").forEach(section => {
        new ImageUploader(section, imagePreviewModal);
    });
});