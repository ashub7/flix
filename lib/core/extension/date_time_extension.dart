import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime{
  get formatted => DateFormat('dd/MM/yyyy').format(this);
}