import 'dart:math';

class Word {
  final String text;
  final double confidence;
  final List<Point<int>> boundingBox;

  Word(this.text, this.confidence, this.boundingBox);
}

class Document {
  final List<Word> words;

  Document(this.words);

  String reconstructText() {
    // Sort words by y-coordinate (top to bottom)
    words.sort((a, b) => a.boundingBox[0].y.compareTo(b.boundingBox[0].y));

    String result = '';
    int currentY = words[0].boundingBox[0].y;
    List<Word> currentLine = [];

    for (var word in words) {
      if ((word.boundingBox[0].y - currentY).abs() > 10) {
        // New line detected
        currentLine.sort((a, b) => a.boundingBox[0].x.compareTo(b.boundingBox[0].x));
        result += currentLine.map((w) => w.text).join(' ') + '\n';
        currentLine = [];
        currentY = word.boundingBox[0].y;
      }
      currentLine.add(word);
    }

    // Add the last line
    if (currentLine.isNotEmpty) {
      currentLine.sort((a, b) => a.boundingBox[0].x.compareTo(b.boundingBox[0].x));
      result += currentLine.map((w) => w.text).join(' ');
    }

    return result;
  }
}

Document extractDocument(Map<String, dynamic> ocrResult) {
  List<Word> words = [];

  for (var wordData in ocrResult['words']) {
    String text = wordData['text'];
    double confidence = wordData['confidence'];
    List<Point<int>> boundingBox = (wordData['boundingBox']['vertices'] as List)
        .map((vertex) => Point<int>(vertex['x'], vertex['y']))
        .toList();

    words.add(Word(text, confidence, boundingBox));
  }

  return Document(words);
}

// void main() {
//   // Your OCR result goes here
//   Map<String, dynamic> ocrResult = {
//     'words': [
//       // ... (your OCR data)
//     ]
//   };

//   Document document = extractDocument(ocrResult);
//   String reconstructedText = document.reconstructText();
//   print(reconstructedText);
// }