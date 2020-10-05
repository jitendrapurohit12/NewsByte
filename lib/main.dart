import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:news_shot/app/news_byte_app.dart';
import 'package:news_shot/injection.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(NewsByteApp());
}
