import 'package:flutter/material.dart';
import 'package:myaniapp/providers/shared_preferrences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  @override
  set state(AppSettings value) {
    super.state = value;
    syncToStorage();
  }

  @override
  bool updateShouldNotify(_, __) {
    return true;
  }

  Future<bool> login(String token) {
    state = state..token = token;
    return ref.read(sharedPrefProvider).setString(Setting.token.setting, token);
  }

  Future<bool> logout() {
    state = state..token = null;
    return ref.read(sharedPrefProvider).remove(Setting.token.setting);
  }

  void changeTheme(ThemeMode theme) {
    state = state..theme = theme;
  }

  void syncToStorage() {
    var settings = ref.read(sharedPrefProvider);
    settings.setString(Setting.animeList.setting, state.animeList.name);
    settings.setString(Setting.mangaList.setting, state.mangaList.name);
    settings.setString(Setting.fallbackList.setting, state.fallbackList.name);
    settings.setString(Setting.theme.setting, state.theme.name);
    if (state.token?.isNotEmpty == true) {
      settings.setString(Setting.token.setting, state.token!);
    }
  }

  @override
  AppSettings build() {
    var prefs = ref.watch(sharedPrefProvider);
    var animeList = ListStyle.values
            .byName(prefs.getString(Setting.animeList.setting) ?? 'grid'),
        mangaList = ListStyle.values
            .byName(prefs.getString(Setting.mangaList.setting) ?? 'grid'),
        fallbackList = ListStyle.values
            .byName(prefs.getString(Setting.fallbackList.setting) ?? 'grid'),
        theme = ThemeMode.values
            .byName(prefs.getString(Setting.theme.setting) ?? 'system'),
        token = prefs.getString(Setting.token.setting);

    return AppSettings(animeList, mangaList, fallbackList, theme, token);
  }
}

enum ListStyle {
  grid,
  detailedList,
  simpleList,
}

enum Setting {
  animeList('list.anime'),
  mangaList('list.manga'),
  fallbackList('list.fallback'),
  token('token'),
  theme('theme');

  const Setting(this.setting);
  final String setting;
}

class AppSettings {
  AppSettings(
    this.animeList,
    this.mangaList,
    this.fallbackList,
    this.theme,
    this.token,
  );

  ListStyle animeList;
  ListStyle fallbackList;
  ListStyle mangaList;
  ThemeMode theme;
  String? token;

  // AppSettings(SharedPreferences prefs) {
  //   animeList = ListStyle.values
  //       .byName(prefs.getString(SettingStrings.animeList.setting) ?? 'grid');
  //   mangaList = ListStyle.values
  //       .byName(prefs.getString(SettingStrings.mangaList.setting) ?? 'grid');
  //   fallbackList = ListStyle.values
  //       .byName(prefs.getString(SettingStrings.fallbackList.setting) ?? 'grid');
  //   theme = ThemeMode.values
  //       .byName(prefs.getString(SettingStrings.theme.setting) ?? 'system');
  //   token = prefs.getString(SettingStrings.token.setting);
  // }
}
