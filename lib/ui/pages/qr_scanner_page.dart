import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _cameraController = MobileScannerController();

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
          for (final barcode in barcodes) {
            debugPrint('Barcode scanned => ${barcode.rawValue}');
            if (barcode.rawValue?.isNotEmpty == true) {
              showDialog(
                context: context,
                builder: (context) {
                  return BottomSheet(
                    builder: (context) {
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
                              barcode.rawValue!,
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
                                  Navigator.of(context).pop();
                                  // TODO: Proceed to next screen
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Theme.of(context)
                                        .buttonTheme
                                        .colorScheme
                                        ?.primary,
                                  ),
                                ),
                                child: Text(
                                  'Proceed',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme
                                        ?.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onClosing: () {},
                  );
                },
              );
            }
          }
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
