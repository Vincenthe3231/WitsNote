document.addEventListener("DOMContentLoaded", function () {
    writer = document.getElementById("typewriter");

    let i = 0;
    const text = "You can create visually appealing content by incorporating infographics, charts, and images.";
    const speed = 10;

    function typeWriter(){
        if (i < text.length){
            writer.innerHTML += text.charAt(i);
            i++;
            setTimeout(typeWriter, speed);
        }
    }
    typeWriter();
})