import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState {
  final bool isDarkMode;
  final bool isNeonMode;
  const ThemeState({required this.isDarkMode, required this.isNeonMode});

  ThemeState copyWith({bool? isDarkMode, bool? isNeonMode}) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isNeonMode: isNeonMode ?? this.isNeonMode,
    );
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState(isDarkMode: true, isNeonMode: true));

  void setDarkMode(bool value) {
    state = state.copyWith(isDarkMode: value);
  }

  void setNeonMode(bool value) {
    state = state.copyWith(isNeonMode: value);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});


