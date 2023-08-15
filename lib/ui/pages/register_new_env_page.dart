import 'package:flutter/material.dart';

class RegisterNewEnvPage extends StatefulWidget {
  const RegisterNewEnvPage({super.key});

  @override
  State<RegisterNewEnvPage> createState() => _RegisterNewEnvPageState();
}

class _RegisterNewEnvPageState extends State<RegisterNewEnvPage> {
  final TextEditingController _envTextController = TextEditingController();
  final TextEditingController _surTextController = TextEditingController();

  @override
  void dispose() {
    _envTextController.dispose();
    _surTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Home',
                style: textTheme.displayMedium,
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _envTextController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.secondary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.surfaceVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'e.g. John\'s Home',
                  labelText: 'Home name',
                ),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                autocorrect: false,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _surTextController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.secondary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.surfaceVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'e.g. Living Room',
                  labelText: 'Surrounding name',
                ),
                textCapitalization: TextCapitalization.words,
                maxLines: 1,
                autocorrect: false,
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      'Create',
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
