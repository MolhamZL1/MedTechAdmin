import 'package:flutter/material.dart';

class AiComposer extends StatefulWidget {
  const AiComposer({super.key, this.onSend, this.loading = false});
  final ValueChanged<String>? onSend;
  final bool loading;

  @override
  State<AiComposer> createState() => _AiComposerState();
}

class _AiComposerState extends State<AiComposer> {
  final _textCtrl = TextEditingController();

  void _handleSend() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;
    widget.onSend?.call(text);
    _textCtrl.clear();
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textCtrl,
                style: theme.textTheme.bodyMedium,
                onSubmitted: (_) => _handleSend(),
                decoration: const InputDecoration(hintText: "اكتب سؤالك…"),
              ),
            ),
            const SizedBox(width: 8),
            widget.loading
                ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                : ElevatedButton.icon(
                  onPressed: _handleSend,
                  icon: const Icon(Icons.send_rounded),
                  label: const Text("إرسال"),
                ),
          ],
        ),
      ),
    );
  }
}
