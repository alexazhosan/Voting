import 'package:Voting/src/blocs/blocs.dart';
import 'package:Voting/src/styles/app_colors.dart';
import 'package:Voting/src/styles/text_styles.dart';

class Buffer {
  static double height;
  static double width;
  static AppColors appColors;
  static TextStyles textStyles;
  static BlocObjects blocObjects;

  Buffer() {
    height = 0.0;
    width = 0.0;
    appColors = AppColors();
    textStyles = TextStyles();
    blocObjects = BlocObjects();
  }
}