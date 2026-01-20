import 'dart:ui';
import '../models/word_pair.dart';

class WordPacks {
  static final List<WordPair> _allWordsEn = [
    // Pack 1
    const WordPair(id: 'p1_1', civilianWord: 'Pizza', mrWhiteWord: 'Pasta'),
    const WordPair(id: 'p1_2', civilianWord: 'Cat', mrWhiteWord: 'Dog'),
    const WordPair(id: 'p1_3', civilianWord: 'Coffee', mrWhiteWord: 'Tea'),
    const WordPair(id: 'p1_4', civilianWord: 'Superman', mrWhiteWord: 'Batman'),
    // Pack 2
    const WordPair(id: 'p2_1', civilianWord: 'Beach', mrWhiteWord: 'Desert'),
    const WordPair(id: 'p2_2', civilianWord: 'Guitar', mrWhiteWord: 'Violin'),
    const WordPair(id: 'p2_3', civilianWord: 'Train', mrWhiteWord: 'Bus'),
    const WordPair(id: 'p2_4', civilianWord: 'Apple', mrWhiteWord: 'Orange'),
    // Pack 3
    const WordPair(id: 'p3_1', civilianWord: 'Snow', mrWhiteWord: 'Rain'),
    const WordPair(id: 'p3_2', civilianWord: 'Doctor', mrWhiteWord: 'Teacher'),
    const WordPair(id: 'p3_3', civilianWord: 'Castle', mrWhiteWord: 'Palace'),
    const WordPair(id: 'p3_4', civilianWord: 'Rocket', mrWhiteWord: 'Airplane'),
  ];

  static final List<WordPair> _allWordsPt = [
    // Pack 1
    const WordPair(id: 'p1_1', civilianWord: 'Pizza', mrWhiteWord: 'Massa'),
    const WordPair(id: 'p1_2', civilianWord: 'Gato', mrWhiteWord: 'Cão'),
    const WordPair(id: 'p1_3', civilianWord: 'Café', mrWhiteWord: 'Chá'),
    const WordPair(
      id: 'p1_4',
      civilianWord: 'Super-Homem',
      mrWhiteWord: 'Batman',
    ),
    // Pack 2
    const WordPair(id: 'p2_1', civilianWord: 'Praia', mrWhiteWord: 'Deserto'),
    const WordPair(
      id: 'p2_2',
      civilianWord: 'Guitarra',
      mrWhiteWord: 'Violino',
    ),
    const WordPair(
      id: 'p2_3',
      civilianWord: 'Comboio',
      mrWhiteWord: 'Autocarro',
    ),
    const WordPair(id: 'p2_4', civilianWord: 'Maçã', mrWhiteWord: 'Laranja'),
    // Pack 3
    const WordPair(id: 'p3_1', civilianWord: 'Neve', mrWhiteWord: 'Chuva'),
    const WordPair(
      id: 'p3_2',
      civilianWord: 'Médico',
      mrWhiteWord: 'Professor',
    ),
    const WordPair(id: 'p3_3', civilianWord: 'Castelo', mrWhiteWord: 'Palácio'),
    const WordPair(id: 'p3_4', civilianWord: 'Foguetão', mrWhiteWord: 'Avião'),
  ];

  static List<WordPair> getWords(Locale locale) {
    if (locale.languageCode == 'pt') {
      return _allWordsPt;
    }
    return _allWordsEn;
  }

  // Backwards compatibility for MonetizationController which needs a default list
  // Ideally MonetizationController should also be locale-aware, but for counting unique IDs, any list with correct IDs works.
  static List<WordPair> get allWords => _allWordsEn;
}
