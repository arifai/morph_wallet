import 'package:flutter/material.dart';

@immutable
abstract class MorphEvent {}

class StartupEvent extends MorphEvent {
  StartupEvent();
}

