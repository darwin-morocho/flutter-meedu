/// check if a string has at least one especial character
bool containsSpecialCharacter(String text) {
  return RegExp(r"""^(?=.*?[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?])""")
      .hasMatch(text);
}

bool containsSpecialCharacterExceptUnderscore(String text) {
  return RegExp(r"""^(?=.*?[!@#$%^&*()+\-=\[\]{};':"\\|,.<>\/?])""")
      .hasMatch(text);
}
