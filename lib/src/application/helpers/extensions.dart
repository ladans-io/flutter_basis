import 'dart:convert';

extension StringX on String {
  String clearNumberFormatting() {
    return
      replaceAll('.', '')
      .replaceAll('/', '')
      .replaceAll(',', '')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll(' ', '')
      .replaceAll('-', '');
  }

  List<String> get multilines => const LineSplitter().convert(this);
}

extension UpperCaseInitials on String {
  String uppercaseInitials() {
    return toLowerCase().split(' ')
      .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
      .join(' ');
  }
}

extension RoundUpAbsolute on double {
  int roundUpAbsolute() {
    return isNegative ? floor() : ceil();
  }
}

extension ContainsManyDots on String {
  bool get containsManyDots => '.'.allMatches(this).length > 1;
}

extension RemoveLastChar on String {
  String removeLastChar() => substring(0, length - 1);
}

extension ReplaceCommaPerDot on String {
  String replaceCommaPerDot() => replaceAll(',', '.');
}

extension ClearRealFormattig on String {
  double clearRealFormatting() {
    return double.parse(
      replaceAll('R\$', '')
      .replaceAll('.', '')
      .replaceAll(',', '.')
      .trim(),
    );
  }
}

extension ClearAccentuation on String {
  String clearAccentuation() {
    final aUpperCase = 'a'.toUpperCase();
    final eUpperCase = 'e'.toUpperCase();
    final iUpperCase = 'i'.toUpperCase();
    final oUpperCase = 'o'.toUpperCase();
    final uUpperCase = 'u'.toUpperCase();

    return replaceAll('à', 'a')
          .replaceAll('á', 'a')
          .replaceAll('ä', 'a')
          .replaceAll('ã', 'a')
          .replaceAll('â', 'a')
          .replaceAll('à'.toUpperCase(), aUpperCase)
          .replaceAll('á'.toUpperCase(), aUpperCase)
          .replaceAll('ä'.toUpperCase(), aUpperCase)
          .replaceAll('ã'.toUpperCase(), aUpperCase)
          .replaceAll('â'.toUpperCase(), aUpperCase)

          .replaceAll('è', 'a')
          .replaceAll('é', 'a')
          .replaceAll('ë', 'a')
          .replaceAll('ê', 'a')
          .replaceAll('è'.toUpperCase(), eUpperCase)
          .replaceAll('é'.toUpperCase(), eUpperCase)
          .replaceAll('ë'.toUpperCase(), eUpperCase)
          .replaceAll('ê'.toUpperCase(), eUpperCase)

          .replaceAll('ì', 'i')
          .replaceAll('í', 'i')
          .replaceAll('ï', 'i')
          .replaceAll('î', 'i')
          .replaceAll('ì'.toUpperCase(), iUpperCase)
          .replaceAll('í'.toUpperCase(), iUpperCase)
          .replaceAll('ï'.toUpperCase(), iUpperCase)
          .replaceAll('î'.toUpperCase(), iUpperCase)

          .replaceAll('ò', 'o')
          .replaceAll('ó', 'o')
          .replaceAll('ö', 'o')
          .replaceAll('ô', 'o')
          .replaceAll('õ', 'o')
          .replaceAll('ò'.toUpperCase(), oUpperCase)
          .replaceAll('ó'.toUpperCase(), oUpperCase)
          .replaceAll('ö'.toUpperCase(), oUpperCase)
          .replaceAll('ô'.toUpperCase(), oUpperCase)
          .replaceAll('õ'.toUpperCase(), oUpperCase)

          .replaceAll('ù', 'u')
          .replaceAll('ú', 'u')
          .replaceAll('ü', 'u')
          .replaceAll('û', 'u')
          .replaceAll('ù'.toUpperCase(), uUpperCase)
          .replaceAll('ú'.toUpperCase(), uUpperCase)
          .replaceAll('ü'.toUpperCase(), uUpperCase)
          .replaceAll('û'.toUpperCase(), uUpperCase);
  }
}

extension FileExtensionX on String {
  bool isFileImage() {
    return toLowerCase().contains('.jpeg') ||
    toLowerCase().contains('.jpg') ||
    toLowerCase().contains('.png');
  }
}