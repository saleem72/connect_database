//

// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:connect_database/helpers/routing/nav_links.dart';
import 'package:connect_database/screens/main_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../connection_manager/connection_manager_bloc/connection_manager_bloc.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    }

    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode scan'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          _buildScanView(context),
          Positioned(
            bottom: 10,
            child: _buildResult(context),
          ),
          Positioned(
            top: 10,
            child: _buildControlButtons(context),
          ),
        ],
      ),
    );
  }

  Widget _buildScanView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) => onQRViewCreated(context, controller),
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).colorScheme.secondary,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  Widget _buildControlButtons(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {});
            },
            icon: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Icon(
                    (snapshot.data!) ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {});
            },
            icon: FutureBuilder<CameraFacing?>(
              future: controller?.getCameraInfo(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return const Icon(
                    Icons.switch_camera,
                    color: Colors.white,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult(context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        barcode != null ? 'Result: ${barcode?.code ?? ''}' : 'Scan a code',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
        maxLines: 3,
      ),
    );
  }

  void onQRViewCreated(BuildContext context, QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.pauseCamera();
    controller.resumeCamera();

    controller.scannedDataStream.listen((barcode) {
      _handleBarcode(context, barcode);
    });
  }

  void _handleBarcode(BuildContext context, Barcode barcode) {
    if (barcode.code != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BarcodeScanResult(barcode: barcode.code!)));
    }
  }
}
