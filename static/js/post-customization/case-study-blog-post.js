document.addEventListener("DOMContentLoaded", function () {
    writer = document.getElementById("typewriter");

    let i = 0;
    const text = "Your research findings of everything, everywhere, all at once. The delivery of precious discovery and academic insights is always a testament to the power of interdisciplinary collaboration and innovative thinking, to pave up an erudite future.";
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