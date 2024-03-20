import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../base/di/inject_config.dart';
import '../../core/model/ui_state.dart';
import '../../route/routes.dart';
import '../bloc/add_env_cubit.dart';
import '../bloc/qr_code_scanner_cubit.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage>
    with TickerProviderStateMixin {
  final MobileScannerController _cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  Widget _buildResultBottomSheet(String barcode) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Scanned data:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            barcode,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                if(true) {
                  Navigator.of(context).pop();
                  Navigator.of(context).popAndPushNamed(
                      ShaRoutes.registerNewEnvRoute);
                } else {
                  Navigator.of(context).pop();
                  Navigator.of(context).popAndPushNamed(
                      ShaRoutes.addDeviceRoute);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).buttonTheme.colorScheme?.primary,
                ),
              ),
              child: Text(
                'Proceed',
                style: TextStyle(
                  color: Theme.of(context).buttonTheme.colorScheme?.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? qrData = '';
    return  BlocProvider(create: (_) => QrCodeScannerCubit(getIt.get()),
      child: BlocListener<QrCodeScannerCubit, UIState> (
        listener: (context, state) {
          if(state is SuccessState) {
            bool isEnvironmentAvailable = state.data;
            if(isEnvironmentAvailable) {
              Navigator.of(context).popAndPushNamed(ShaRoutes.addDeviceRoute, arguments: qrData);
            } else {
              Navigator.of(context).popAndPushNamed(ShaRoutes.registerNewEnvRoute,  arguments: qrData);
            }
          }
        },
        child: BlocBuilder<QrCodeScannerCubit, UIState>(
          builder: (context, state) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => _cameraController.toggleTorch(),
                child: ValueListenableBuilder(
                  valueListenable: _cameraController.torchState,
                  builder: (context, state, chile) {
                    switch (state) {
                      case TorchState.off:
                        return const Icon(Icons.flashlight_off);
                      case TorchState.on:
                        return const Icon(Icons.flashlight_on);
                    }
                  },
                ),
              ),
              body: MobileScanner(
                controller: _cameraController,
                onDetect: (capture) {
                  final barcodes = capture.barcodes;
                  qrData = barcodes[0].rawValue;
                  log('Barcode scanned => ${qrData}');
                  if(qrData != null) {
                    context.read<QrCodeScannerCubit>().fetchEnvironments();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }
}
