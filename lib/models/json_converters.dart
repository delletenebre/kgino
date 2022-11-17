import 'package:json_annotation/json_annotation.dart';

class DoubleConverter implements JsonConverter<double, dynamic> {
   const DoubleConverter();

   @override
   double fromJson(dynamic json) => double.tryParse(json.toString()) ?? 0.0;

   @override
   double toJson(double object) => object;
 }

 class IntConverter implements JsonConverter<int, dynamic> {
   const IntConverter();

   @override
   int fromJson(dynamic json) => int.tryParse(json.toString()) ?? 0;

   @override
   int toJson(int object) => object;
 }