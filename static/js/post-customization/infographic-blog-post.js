document.addEventListener("DOMContentLoaded", () => {
    const infographicPage = new InfographicPage();
    infographicPage.init();
});

class InfographicPage {
    constructor() {
        this.writer = document.getElementById("typewriter");
        this.addSectionBtn = document.getElementById("addSectionBtn");
        this.sectionsContainer = document.getElementById("infographic-sections-container");
        this.sectionTemplate = document.getElementById("section-template");
        this.buttonWrapper = this.addSectionBtn?.parentElement;
        this.sectionCount = this.sectionsContainer?.querySelectorAll('.infographic-section:not(.d-none)').length || 0;

        this.modalPreviewImage = document.getElementById("modalPreviewImage");
        this.modalElement = document.getElementById("imagePreviewModal");
        this.bootstrapModal = this.modalElement ? new bootstrap.Modal(this.modalElement) : null;
        this.currentZoom = 1;
    }

    init() {
        this.initTypewriter();
        this.initAddSection();
        this.initImageModal();
        this.initImageUpload();
    }

    initTypewriter() {
        if (!this.writer) return;
        const text = "You can create visually appealing content by incorporating infographics, charts, and images.";
        let i = 0;

        const typeWriter = () => {
            if (i < text.length) {
                this.writer.textContent += text.charAt(i++);
                requestAnimationFrame(typeWriter);
            }
        };
        typeWriter();
    }

    initAddSection() {
        if (!this.addSectionBtn || !this.sectionTemplate) return;

        this.addSectionBtn.addEventListener('click', () => {
            this.sectionCount++;
            const newSection = this.sectionTemplate.cloneNode(true);
            newSection.id = `section-${this.sectionCount}`;
            newSection.classList.remove('d-none');

            const sectionNumber = newSection.querySelector('.section-number');
            const sectionTitle = newSection.querySelector('.section-title');
            const sectionTextarea = newSection.querySelector('.section-textarea');

            if (sectionNumber) sectionNumber.textContent = this.sectionCount;
            if (sectionTitle) sectionTitle.value = '';
            if (sectionTextarea) {
                sectionNumber.style.background = "linear-gradient(90deg, #ff7e5f, #feb47b)";
                sectionTextarea.value = '';
                sectionTextarea.style.resize = 'none';
            }

            this.sectionsContainer.insertBefore(newSection, this.buttonWrapper);
            newSection.scrollIntoView({ behavior: 'smooth', block: 'end' });
        });
    }

    initImageModal() {
        if (!this.modalElement || !this.modalPreviewImage) return;

        this.modalPreviewImage.addEventListener("wheel", (e) => {
            e.preventDefault();
            this.currentZoom += (e.deltaY < 0 ? 0.1 : -0.1);
            this.currentZoom = Math.max(0.5, Math.min(5, this.currentZoom));
            this.modalPreviewImage.style.transform = `scale(${this.currentZoom})`;
        });

        this.modalElement.addEventListener("hidden.bs.modal", () => {
            this.currentZoom = 1;
            this.modalPreviewImage.style.transform = "scale(1)";
        });
    }

    initImageUpload() {
        const sections = document.querySelectorAll("section[data-section]");
        sections.forEach(section => {
            const plusIcon = section.querySelector(".bi-plus");
            const fileInput = section.querySelector("input[type='file']");
            const container = section.querySelector(".imageContainer");

            if (!plusIcon || !fileInput || !container) return;

            plusIcon.addEventListener("click", () => fileInput.click());

            fileInput.addEventListener("change", (e) => {
                [...e.target.files].forEach(file => {
                    if (!file.type.startsWith("image/")) return;

                    const reader = new FileReader();
                    reader.onload = (ev) => {
                        const wrapper = document.createElement("div");
                        wrapper.className = "position-relative";

                        const img = document.createElement("img");
                        img.src = ev.target.result;
                        img.className = "img-thumbnail";
                        img.style.maxWidth = "150px";
                        img.style.cursor = "pointer";

                        img.addEventListener("click", () => {
                            this.modalPreviewImage.src = img.src;
                            this.currentZoom = 1;
                            this.modalPreviewImage.style.transform = "scale(1)";
                            this.bootstrapModal?.show();
                        });

                        const removeBtn = document.createElement("button");
                        removeBtn.innerHTML = "&times;";
                        removeBtn.className = "btn btn-sm btn-danger position-absolute top-0 end-0";
                        removeBtn.style.transform = "translate(50%, -50%)";
                        removeBtn.addEventListener("click", () => wrapper.remove());

                        wrapper.appendChild(img);
                        wrapper.appendChild(removeBtn);
                        container.appendChild(wrapper);
                    };
                    reader.readAsDataURL(file);
                });

                fileInput.value = '';
            });
        });
    }
}
