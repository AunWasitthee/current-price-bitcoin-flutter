
import 'package:intl/intl.dart';


String convertThousandInput(num? value) {
  if (value == null) {
    return '';
  } else {
    final String newFormat;
    newFormat = NumberFormat('#,##0').format(value);
    return newFormat;
  }
}
String convertThousand(num? value) {
  if (value == null) {
    return '';
  } else {
    final String newFormat;
    newFormat = NumberFormat('#,##0.00').format(value);
    return newFormat;
  }
}

String removeThousand(String? value){
  if(value == null){
    return '';
  }else {
    return value.replaceAll(",","");
  }

}