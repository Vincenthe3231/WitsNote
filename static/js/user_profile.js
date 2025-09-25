document.addEventListener('DOMContentLoaded', () => {
    const tabButtons = document.querySelectorAll('.tab-button');
    const tabPanels = document.querySelectorAll('.tab-panel');
    const skillsList = document.getElementById('skills-list');
    const workLinksList = document.getElementById('work-links-list');
    const changePhotoBtn = document.getElementById("changePhotoBtn");
    const profilePicInput = document.getElementById("profilePicUpload");
    const cancelBtn = document.getElementById("cancelChangePhoto");
    const uploadBtn = document.getElementById("uploadPhoto");

    // Skill Modal Elements
    const skillModalOverlay = document.getElementById('addSkillModal');
    const skillInput = document.getElementById('skillInput');

    // Work Link Modal Elements
    const workLinkModalOverlay = document.getElementById('addWorkLinkModal');
    const linkTitleInput = document.getElementById('linkTitleInput');
    const linkUrlInput = document.getElementById('linkUrlInput');

    // -------------------------------
    // Helper: Get CSRF token from cookie
    // -------------------------------
    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
    const csrftoken = getCookie('csrftoken');

    // -------------------------------
    // Tab switching
    // -------------------------------
    tabButtons.forEach((btn, index) => {
        btn.addEventListener('click', () => {
            tabButtons.forEach(b => b.classList.remove('active'));
            tabPanels.forEach(p => p.style.display = 'none');
            btn.classList.add('active');
            tabPanels[index].style.display = 'block';
        });
    });

    // -------------------------------
    // Close modals when clicking outside
    // -------------------------------
    skillModalOverlay.addEventListener('click', (event) => {
        if (event.target === skillModalOverlay) {
            hideAddSkillModal();
        }
    });

    workLinkModalOverlay.addEventListener('click', (event) => {
        if (event.target === workLinkModalOverlay) {
            hideAddWorkLinkModal();
        }
    });

    // -------------------------------
    // Add Skill
    // -------------------------------
    window.showAddSkillModal = function () {
        skillModalOverlay.classList.add('visible');
        skillInput.focus();
    };

    window.hideAddSkillModal = function () {
        skillModalOverlay.classList.remove('visible');
        skillInput.value = '';
    };

    window.addSkill = function () {
        const newSkill = skillInput.value.trim();
        if (newSkill) {
            fetch('/user/add-skill/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': csrftoken
                },
                body: JSON.stringify({ skill: newSkill })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const listItem = document.createElement('li');
                        listItem.setAttribute('data-id', newSkill);
                        listItem.innerHTML = `${newSkill}<button class="remove-btn" data-type="skill"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18" height="18"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zm2.46-7.12l1.41-1.41L12 12.59l2.12-2.12 1.41 1.41L13.41 14l2.12 2.12-1.41 1.41L12 15.41l-2.12 2.12-1.41-1.41L10.59 14l-2.13-2.12zM15.5 4l-1-1h-5l-1 1H5v2h14V4z"/></svg></button>`;
                        skillsList.appendChild(listItem);
                        hideAddSkillModal();
                    } else {
                        console.error('Error adding skill:', data.error);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    };

    skillInput.addEventListener('keypress', (event) => {
        if (event.key === 'Enter') {
            addSkill();
        }
    });

    // -------------------------------
    // Add Work Link
    // -------------------------------
    window.showAddWorkLinkModal = function () {
        workLinkModalOverlay.classList.add('visible');
        linkTitleInput.focus();
    };

    window.hideAddWorkLinkModal = function () {
        workLinkModalOverlay.classList.remove('visible');
        linkTitleInput.value = '';
        linkUrlInput.value = '';
    };

    window.addWorkLink = function () {
        const linkTitle = linkTitleInput.value.trim();
        let linkUrl = linkUrlInput.value.trim();

        if (linkTitle && linkUrl) {
            if (!linkUrl.startsWith('http://') && !linkUrl.startsWith('https://')) {
                linkUrl = `http://${linkUrl}`;
            }

            fetch('/user/add-work-link/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': csrftoken
                },
                body: JSON.stringify({ title: linkTitle, url: linkUrl })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const link = data.link; // backend returns {id, title, url}
                        const listItem = document.createElement('li');
                        listItem.setAttribute('data-id', link.id);
                        listItem.innerHTML = `
                    <a href="${link.url}" target="_blank">${link.title}</a>
                    <button class="remove-btn" data-type="work-link">
                        <svg xmlns="http://www.w3.org/2000/svg" 
                             viewBox="0 0 24 24" 
                             fill="currentColor" width="18" height="18">
                            <path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zm2.46-7.12l1.41-1.41L12 12.59l2.12-2.12 1.41 1.41L13.41 14l2.12 2.12-1.41 1.41L12 15.41l-2.12 2.12-1.41-1.41L10.59 14l-2.13-2.12zM15.5 4l-1-1h-5l-1 1H5v2h14V4z"/>
                        </svg>
                    </button>`;
                        workLinksList.appendChild(listItem);
                        hideAddWorkLinkModal();
                    } else {
                        console.error('Error adding work link:', data.error);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        }
    };


    linkUrlInput.addEventListener('keypress', (event) => {
        if (event.key === 'Enter') {
            addWorkLink();
        }
    });

    linkTitleInput.addEventListener('keypress', (event) => {
        if (event.key === 'Enter') {
            linkUrlInput.focus();
        }
    });

    // -------------------------------
    // Remove Skill / Work Link
    // -------------------------------
    const handleRemoveItem = async (type, item) => {
        const id = item.getAttribute('data-id');
        let endpoint = '';
        let body = {};

        if (type === 'work-link') {
            endpoint = '/user/remove-work-link/';
            body = { id: id }; // ✅ now send ID
        } else if (type === 'skill') {
            endpoint = '/user/remove-skill/';
            body = { skill: id };
        }

        try {
            const response = await fetch(endpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': csrftoken
                },
                body: JSON.stringify(body)
            });

            const data = await response.json();

            if (data.success) {
                item.remove();
                console.log(`${type} removed successfully.`);
            } else {
                console.error(`Error removing ${type}:`, data.error);
            }
        } catch (error) {
            console.error(`Something went wrong while removing the ${type}:`, error);
        }
    };


    // Add a single event listener to the parent list for event delegation
    skillsList.addEventListener('click', (event) => {
        const button = event.target.closest('.remove-btn');
        if (button) {
            const listItem = button.closest('li');
            handleRemoveItem('skill', listItem);
        }
    });

    workLinksList.addEventListener('click', (event) => {
        const button = event.target.closest('.remove-btn');
        if (button) {
            const listItem = button.closest('li');
            handleRemoveItem('work-link', listItem);
        }
    });
    // -------------------------------
    // Phone Modal
    // -------------------------------
    window.showEditPhoneModal = function () {
        document.getElementById('editPhoneModal').classList.add('visible');
    }
    window.hideEditPhoneModal = function () {
        document.getElementById('editPhoneModal').classList.remove('visible');
    }
    window.savePhoneChange = async function () {
        const newPhone = document.getElementById('editPhoneInput').value.trim();
        if (!newPhone) return;

        try {
            const response = await fetch('/user/update-profile/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': csrftoken,
                },
                body: JSON.stringify({ phone: newPhone }),
            });

            const data = await response.json();
            if (data.success) {
                document.getElementById('phone-value').textContent = newPhone;
                hideEditPhoneModal();
            } else {
                console.error('Error updating phone:', data.error);
            }
        } catch (err) {
            console.error('Request failed:', err);
        }
    }

    // -------------------------------
    // Profession Modal
    // -------------------------------
    window.showEditProfessionModal = function () {
        document.getElementById('editProfessionModal').classList.add('visible');
    }
    window.hideEditProfessionModal = function () {
        document.getElementById('editProfessionModal').classList.remove('visible');
    }
    window.saveProfessionChange = async function () {
        const newProfession = document.getElementById('editProfessionInput').value.trim();
        if (!newProfession) return;

        try {
            const response = await fetch('/user/update-profile/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRFToken': csrftoken,
                },
                body: JSON.stringify({ profession: newProfession }),
            });

            const data = await response.json();
            if (data.success) {
                document.getElementById('profession-value').textContent = newProfession;
                hideEditProfessionModal();
            } else {
                console.error('Error updating profession:', data.error);
            }
        } catch (err) {
            console.error('Request failed:', err);
        }
    }

    changePhotoBtn.addEventListener("click", () => {
        document.getElementById("changePhotoModal").classList.add("visible");
    });

    window.hideChangePhotoModal = function () {
        document.getElementById("changePhotoModal").classList.remove("visible");
    }

    window.uploadProfilePic = function () {
        const fileInput = document.getElementById("profilePicUpload");
        const file = fileInput.files[0];

        if (!file) {
            alert("Please select a file first.");
            return;
        }

        const formData = new FormData();
        formData.append("profile_picture", file);

        fetch("/user/upload-profile-pic/", {
            method: "POST",
            body: formData,
            headers: {
                "X-CSRFToken": csrftoken,
            },
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.querySelector(".profile-picture").src = data.image_url;
                    document.getElementById("changePhotoModal").classList.remove("visible");
                } else {
                    alert("Upload failed: " + data.error);
                }
            })
            .catch(error => {
                console.error("Error:", error);
                alert("Something went wrong!");
            });
    };


});
