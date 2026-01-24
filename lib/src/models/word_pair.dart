enum WordCategory {
  countries,
  objects,
  superheroes,
  knownPersons,
  professions,
  animals,
  foods,
  sports,
}

class WordPair {
  final String id;
  final String civilianWord;
  final String mrWhiteWord;
  final WordCategory category;
  final String languageCode;

  const WordPair({
    required this.id,
    required this.civilianWord,
    required this.mrWhiteWord,
    required this.category,
    required this.languageCode,
  });
}
