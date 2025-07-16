document.addEventListener("DOMContentLoaded", function() {
    writer = document.getElementById("typewriter");

    let i = 0;
    const text = "You can organize your contents with the aid of headings, subheadings, and bullet points.";
    const speed = 10;

    function typeWriter(){
        if (i < text.length){
            writer.innerHTML += text.charAt(i);
            i++
            setTimeout(typeWriter, speed);
        }
    }
    typeWriter();
})