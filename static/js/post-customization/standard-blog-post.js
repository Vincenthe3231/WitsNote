document.addEventListener("DOMContentLoaded", function () {
    const writer = document.getElementById("typewriter");
    // writer.setAttribute("contenteditable", "false");

    let i = 0;
    let text = "This is the Standard Blog Post template. The template is designed to help you create a well-structured yet simple-and-clean blog post, allowing you to share your sudden inspiration, ideas, and insights with your audience real quick without extra efforts.";
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