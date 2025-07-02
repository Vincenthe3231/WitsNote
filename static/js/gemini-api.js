// Get references to HTML elements
const introductionText = document.getElementById('introductionText');
const mainContentText = document.getElementById('mainContentText');
const conclusionText = document.getElementById('conclusionText'); // This is the original paragraph for conclusion

const introSummaryBtn = document.getElementById('introSummaryBtn');
const introSummaryOutput = document.getElementById('introSummaryOutput');
const introSummaryText = document.getElementById('introSummaryText');
const introSummaryLoading = document.getElementById('introSummaryLoading');

const summarizeBtn = document.getElementById('summarizeBtn');
const summaryOutput = document.getElementById('summaryOutput');
const summaryText = document.getElementById('summaryText');
const summaryLoading = document.getElementById('summaryLoading');

const generateConclusionBtn = document.getElementById('generateConclusionBtn');
const conclusionOutput = document.getElementById('conclusionOutput');
const generatedConclusionText = document.getElementById('generatedConclusionText'); // This is the span for generated conclusion
const conclusionLoading = document.getElementById('conclusionLoading');

// Function to call the Gemini API
async function callGeminiAPI(prompt, loadingElement) {
    loadingElement.style.display = 'inline-block'; // Show loading spinner
    let chatHistory = [];
    chatHistory.push({ role: "user", parts: [{ text: prompt }] });
    const payload = { contents: chatHistory };
    const apiKey = window.AppConfig.GEMINI_API_KEY;
    const apiUrl = window.AppConfig.GEMINI_API_URL + apiKey;

    try {
        const response = await fetch(apiUrl, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload)
        });
        const result = await response.json();

        if (result.candidates && result.candidates.length > 0 &&
            result.candidates[0].content && result.candidates[0].content.parts &&
            result.candidates[0].content.parts.length > 0) {
            return result.candidates[0].content.parts[0].text;
        } else {
            console.error("Gemini API response structure unexpected:", result);
            return "Error: Could not generate content. Please try again.";
        }
    } catch (error) {
        console.error("Error calling Gemini API:", error);
        return "Error: Failed to connect to the AI service. Please check your network.";
    } finally {
        loadingElement.style.display = 'none'; // Hide loading spinner
    }
}

// Event listener for Summarize Introduction button
introSummaryBtn.addEventListener('click', async () => {
    const content = introductionText.textContent;
    if (content.trim() === "") {
        introSummaryOutput.style.display = 'block';
        introSummaryText.textContent = "Please add some content to the 'Introduction' section to summarize.";
        return;
    }
    const prompt = `Please summarize the following introduction concisely. The summary should be insightful and thought-provoking. If the content is not informative or too short, analyze the sentence and conclude what the author tries to deliver. Your response should exclude unnecessary asterisks and make good use of punctuation:\n\n${content}`;
    introSummaryText.textContent = ''; // Clear previous summary
    introSummaryOutput.style.display = 'block'; // Ensure output area is visible

    const summary = await callGeminiAPI(prompt, introSummaryLoading);
    introSummaryText.textContent = summary;
});

// Event listener for Summarize Main Content button
summarizeBtn.addEventListener('click', async () => {
    const content = mainContentText.textContent;
    if (content.trim() === "") {
        summaryOutput.style.display = 'block';
        summaryText.textContent = "Please add some content to the 'Main Content' section to summarize.";
        return;
    }
    const prompt = `Please summarize the following blog post content concisely. The summary should be insightful and thought-provoking. Else, if the content is not informative or too short, you may analyze the sentence and conclude what the author tries to deliver. Your response should exclude unnecessary asterisks and make good use of punctuation:\n\n${content}`;
    summaryText.textContent = ''; // Clear previous summary
    summaryOutput.style.display = 'block'; // Ensure output area is visible

    const summary = await callGeminiAPI(prompt, summaryLoading);
    summaryText.textContent = summary;
});

// Event listener for Generate Conclusion button
generateConclusionBtn.addEventListener('click', async () => {
    // Use mainContentText to generate the conclusion
    const content = mainContentText.textContent;
    if (content.trim() === "") {
        conclusionOutput.style.display = 'block';
        generatedConclusionText.textContent = "Please add some content to the 'Main Content' section to generate a conclusion.";
        return;
    }
    // Prompt modified to generate a conclusion based on the main content
    const prompt = `Based on the following main content of a blog post, write a compelling conclusion. If the content is not informative or too short, you may analyze the sentence and conclude what the author tries to deliver. Your response should exclude unnecessary asterisks and make good use of punctuation:\n\n${content}`;
    generatedConclusionText.textContent = ''; // Clear previous generated conclusion
    conclusionOutput.style.display = 'block'; // Ensure output area is visible

    const newConclusion = await callGeminiAPI(prompt, conclusionLoading);
    generatedConclusionText.textContent = newConclusion; // Update the span for generated conclusion
});