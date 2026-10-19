import 'package:material_ui/material_ui.dart';

class Gap extends StatelessWidget {
  const new(this.size, {super.key});

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox.square(dimension: size);
}
