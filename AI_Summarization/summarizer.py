from transformers import T5ForConditionalGeneration, T5Tokenizer
import torch

class Summarizer:
    def __init__(self):
        self.model_name = "t5-base"
        self.tokenizer = T5Tokenizer.from_pretrained(self.model_name)
        self.model = T5ForConditionalGeneration.from_pretrained(self.model_name)

        # Set device to GPU if available, else CPU
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self.model.to(self.device)

    def summarize_text(self, text, max_length=150, min_length=30):
        input_text = "summarize: " + text.strip().replace("\n", " ")
        inputs = self.tokenizer.encode(
            input_text,
            return_tensors="pt",
            max_length=512,
            truncation=True
        ).to(self.device)

        summary_ids = self.model.generate(
            inputs,
            max_length=max_length,
            min_length=min_length,
            length_penalty=2.0,
            num_beams=4,
            early_stopping=True
        )

        summary = self.tokenizer.decode(summary_ids[0], skip_special_tokens=True)
        return summary

    def chunk_text(self, text, max_tokens=500):
        tokens = self.tokenizer.encode(text, return_tensors="pt", truncation=False)[0]
        chunks = []
        for i in range(0, len(tokens), max_tokens):
            chunk = tokens[i:i + max_tokens]
            chunks.append(self.tokenizer.decode(chunk, skip_special_tokens=True))
        return chunks

    def summarize_long_text(self, text, max_tokens=500):
        chunks = self.chunk_text(text, max_tokens=max_tokens)
        summaries = [self.summarize_text(chunk) for chunk in chunks]
        return " ".join(summaries)
