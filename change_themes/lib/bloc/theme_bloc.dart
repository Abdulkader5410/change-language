import 'package:change_themes/CashTheme/CashThemeHelper.dart';
import 'package:change_themes/Themes/MyThemes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ThemeEvent>((event, emit) async {
      if (event is GetCurrentThemeEvent) {
        final themeIndex = await CashThemeHelper().getChashedTheme();
        final theme = MyThemes.values
            .firstWhere((myTheme) => myTheme.index == themeIndex);
        emit(LoadedThemeState(themeData: myThemeData[theme]!));
      } else if (event is ChangeThemeEvent) {
        final themeIndex = event.myThemes.index;
        await CashThemeHelper().chashedTheme(themeIndex);
        emit(LoadedThemeState(themeData: myThemeData[event.myThemes]!));
      }
    });
  }
}
