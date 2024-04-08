import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sha/core/model/ui_state.dart';
import 'package:sha/ui/bloc/add_env_cubit.dart';
import 'package:sha/ui/views/loader.dart';

import '../../base/di/inject_config.dart';
import '../../route/routes.dart';

class RegisterNewEnvPage extends StatefulWidget {
  const RegisterNewEnvPage({super.key});

  @override
  State<RegisterNewEnvPage> createState() => _RegisterNewEnvPageState();
}

class _RegisterNewEnvPageState extends State<RegisterNewEnvPage> {
  final TextEditingController _envTextController = TextEditingController();
  final TextEditingController _surTextController = TextEditingController();
  String qrData = '';
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
    qrData = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    return BlocProvider(create: (_) => AddNewEnvironmentBloc(getIt.get(), getIt.get(), getIt.get()),
      child: BlocListener<AddNewEnvironmentBloc, UIState> (
        listener: (context, state) {
          if(state is SuccessState) {
            if(state.data == 1 || state.data == 3)  {
              Navigator.of(context).popAndPushNamed(ShaRoutes.connectDeviceRoute);
            } else if(state.data == 2){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Some Error occured, Please try again'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          } else if(state is FailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Some Error occured, Please try again'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        child: BlocBuilder<AddNewEnvironmentBloc, UIState>(
          builder: (context, state) {
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
                            if(_envTextController.value.text.isNotEmpty && _surTextController.value.text.isNotEmpty) {
                              context.read<AddNewEnvironmentBloc>().createEnvironmentAndSurrounding(qrData, _envTextController.value.text, _surTextController.value.text);
                            }
                            showLoaderDialog(context);
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
          },
        ),
      ),
    );

  }
}
