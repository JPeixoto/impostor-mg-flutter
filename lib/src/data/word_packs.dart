import 'package:flutter/widgets.dart';
import '../models/word_pair.dart';

class WordPacks {
  static const String _fallbackLanguage = 'en';
  static const List<String> supportedLanguages = ['en', 'pt'];

  static final List<WordPair> _allWords = [
    // Pack 1 (EN)
    const WordPair(
      id: 'en_p1_1',
      civilianWord: 'Pizza',
      mrWhiteWord: 'Pasta',
      category: WordCategory.foods,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p1_2',
      civilianWord: 'Cat',
      mrWhiteWord: 'Dog',
      category: WordCategory.animals,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p1_3',
      civilianWord: 'Portugal',
      mrWhiteWord: 'Spain',
      category: WordCategory.countries,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p1_4',
      civilianWord: 'Superman',
      mrWhiteWord: 'Batman',
      category: WordCategory.superheroes,
      languageCode: 'en',
    ),
    // Pack 2 (EN)
    const WordPair(
      id: 'en_p2_1',
      civilianWord: 'Guitar',
      mrWhiteWord: 'Violin',
      category: WordCategory.objects,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p2_2',
      civilianWord: 'Doctor',
      mrWhiteWord: 'Teacher',
      category: WordCategory.professions,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p2_3',
      civilianWord: 'Einstein',
      mrWhiteWord: 'Newton',
      category: WordCategory.knownPersons,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p2_4',
      civilianWord: 'Soccer',
      mrWhiteWord: 'Basketball',
      category: WordCategory.sports,
      languageCode: 'en',
    ),
    // Pack 3 (EN)
    const WordPair(
      id: 'en_p3_1',
      civilianWord: 'Coffee',
      mrWhiteWord: 'Tea',
      category: WordCategory.foods,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p3_2',
      civilianWord: 'Train',
      mrWhiteWord: 'Bus',
      category: WordCategory.objects,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p3_3',
      civilianWord: 'Apple',
      mrWhiteWord: 'Orange',
      category: WordCategory.foods,
      languageCode: 'en',
    ),
    const WordPair(
      id: 'en_p3_4',
      civilianWord: 'Rocket',
      mrWhiteWord: 'Airplane',
      category: WordCategory.objects,
      languageCode: 'en',
    ),
    // Pack 1 (PT)
    const WordPair(
      id: 'pt_p1_1',
      civilianWord: 'Pizza',
      mrWhiteWord: 'Massa',
      category: WordCategory.foods,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p1_2',
      civilianWord: 'Gato',
      mrWhiteWord: 'Cão',
      category: WordCategory.animals,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p1_3',
      civilianWord: 'Portugal',
      mrWhiteWord: 'Espanha',
      category: WordCategory.countries,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p1_4',
      civilianWord: 'Super-Homem',
      mrWhiteWord: 'Batman',
      category: WordCategory.superheroes,
      languageCode: 'pt',
    ),
    // Pack 2 (PT)
    const WordPair(
      id: 'pt_p2_1',
      civilianWord: 'Guitarra',
      mrWhiteWord: 'Violino',
      category: WordCategory.objects,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p2_2',
      civilianWord: 'Médico',
      mrWhiteWord: 'Professor',
      category: WordCategory.professions,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p2_3',
      civilianWord: 'Einstein',
      mrWhiteWord: 'Newton',
      category: WordCategory.knownPersons,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p2_4',
      civilianWord: 'Futebol',
      mrWhiteWord: 'Basquetebol',
      category: WordCategory.sports,
      languageCode: 'pt',
    ),
    // Pack 3 (PT)
    const WordPair(
      id: 'pt_p3_1',
      civilianWord: 'Café',
      mrWhiteWord: 'Chá',
      category: WordCategory.foods,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p3_2',
      civilianWord: 'Comboio',
      mrWhiteWord: 'Autocarro',
      category: WordCategory.objects,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p3_3',
      civilianWord: 'Maçã',
      mrWhiteWord: 'Laranja',
      category: WordCategory.foods,
      languageCode: 'pt',
    ),
    const WordPair(
      id: 'pt_p3_4',
      civilianWord: 'Foguetão',
      mrWhiteWord: 'Avião',
      category: WordCategory.objects,
      languageCode: 'pt',
    ),
  ];

  static List<WordPair> getWords(Locale locale) {
    final languageCode = locale.languageCode.toLowerCase();
    final matches = _allWords
        .where((word) => word.languageCode == languageCode)
        .toList();
    if (matches.isNotEmpty) {
      return matches;
    }
    return _allWords
        .where((word) => word.languageCode == _fallbackLanguage)
        .toList();
  }

  static List<WordPair> getWordsByPack(Locale locale, int packNumber) {
    final languageCode = locale.languageCode.toLowerCase();
    final packId = '_p${packNumber}_';
    final matches = _allWords
        .where(
          (word) =>
              word.languageCode == languageCode && word.id.contains(packId),
        )
        .toList();
    if (matches.isNotEmpty) {
      return matches;
    }
    return _allWords
        .where(
          (word) =>
              word.languageCode == _fallbackLanguage &&
              word.id.contains(packId),
        )
        .toList();
  }

  static bool isSupported(Locale locale) {
    return supportedLanguages.contains(locale.languageCode.toLowerCase());
  }

  static List<WordPair> get allWords => _allWords;
}
