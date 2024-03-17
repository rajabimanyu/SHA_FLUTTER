import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../route/routes.dart';

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
          final codeData = barcodes[0].rawValue;
          log('Barcode scanned => ${codeData}');
          if(codeData != null) {
            if(true) {
              Navigator.of(context).popAndPushNamed(ShaRoutes.registerNewEnvRoute);
            } else {
              Navigator.of(context).popAndPushNamed(ShaRoutes.addDeviceRoute, arguments: codeData);
            }
          }
          // for (final barcode in barcodes) {
          //   debugPrint('Barcode scanned => ${barcode.rawValue}');
          //   if (barcode.rawValue?.isNotEmpty == true) {
          //     showModalBottomSheet(
          //       enableDrag: true,
          //       transitionAnimationController:
          //           BottomSheet.createAnimationController(this),
          //       context: context,
          //       builder: (context) {
          //         return _buildResultBottomSheet(barcode.rawValue!);
          //       },
          //     );
          //   }
          // }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }
}
