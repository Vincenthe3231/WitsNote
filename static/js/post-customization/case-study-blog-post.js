document.addEventListener("DOMContentLoaded", function () {
    // Typewriter Effect
    const writer = document.getElementById("typewriter");
    if (writer) {
        const text = "Your research findings of everything, everywhere, all at once. The delivery of precious discovery and academic insights is always a testament to the power of interdisciplinary collaboration and innovative thinking, paving up an erudite future.";
        let i = 0;
        const speed = 40;

        function typeWriter() {
            if (i < text.length) {
                writer.textContent += text.charAt(i++);
                requestAnimationFrame(typeWriter);
            }
        }
        typeWriter();
    }

    // Image Modal
    const modalPreviewImage = document.getElementById("modalPreviewImage");
    const modalElement = document.getElementById("imagePreviewModal");
    const bootstrapModal = new bootstrap.Modal(modalElement);
    let currentZoom = 1;

    modalPreviewImage.addEventListener("wheel", function (e) {
        e.preventDefault();
        currentZoom += (e.deltaY < 0 ? 0.1 : -0.1);
        currentZoom = Math.max(0.5, Math.min(5, currentZoom));
        modalPreviewImage.style.transform = `scale(${currentZoom})`;
    });

    modalElement.addEventListener("hidden.bs.modal", function () {
        currentZoom = 1;
        modalPreviewImage.style.transform = "scale(1)";
    });

    // Image Upload & Preview Logic
    document.querySelectorAll("section[data-section]").forEach(section => {
        const plusIcon = section.querySelector(".bi-plus");
        const fileInput = section.querySelector("input[type='file']");
        const container = section.querySelector(".imageContainer");

        // Open File Dialog
        plusIcon.addEventListener("click", () => fileInput.click());

        // On File Change
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
                        modalPreviewImage.src = img.src;
                        currentZoom = 1;
                        modalPreviewImage.style.transform = "scale(1)";
                        bootstrapModal.show();
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
});
