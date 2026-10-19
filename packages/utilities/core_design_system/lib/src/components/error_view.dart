import 'package:core_design_system/src/components/empty_state.dart';
import 'package:core_design_system/src/l10n/l10n.dart';
import 'package:material_ui/material_ui.dart';

class ErrorView extends StatelessWidget {
  const new({required this.message, this.onRetry, super.key});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final onRetry = this.onRetry;

    return EmptyState(
      icon: Icons.cloud_off_outlined,
      title: context.l10n.somethingWentWrong,
      message: message,
      action: onRetry == null
          ? null
          : FilledButton.tonal(
              onPressed: onRetry,
              child: Text(context.l10n.tryAgain),
            ),
    );
  }
}
