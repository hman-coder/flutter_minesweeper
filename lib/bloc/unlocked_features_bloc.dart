import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minesweeper_flutter/model/unlockable_features.dart';

class UnlockedFeaturesBloc extends Cubit<UnlockableFeatures> {
  UnlockedFeaturesBloc() : super(UnlockableFeatures.none());

}

