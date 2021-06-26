import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/minesweeper_localizations.dart';

extension ContextLocalizations on BuildContext {
  AppLocalizations localization() => AppLocalizations.of(this)!;
}