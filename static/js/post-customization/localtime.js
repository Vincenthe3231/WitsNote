const publishedDate = document.getElementById("publishedDate");


const now  = new Date();

const localTime = now.toLocaleTimeString();

const options = {
    weekday: 'short',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    timeZoneName: 'short'
};

const localTimeWithOptions = now.toLocaleTimeString(undefined, options);
publishedDate.textContent = `Time Now: ${localTimeWithOptions}`;
publishedDate.style.wordSpacing = "5px";