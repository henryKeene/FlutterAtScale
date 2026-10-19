import 'package:core_design_system/src/tokens/tokens.dart';
import 'package:material_ui/material_ui.dart';

class SectionHeader extends StatelessWidget {
  const new(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Spacing.m,
        Spacing.l,
        Spacing.m,
        Spacing.s,
      ),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
