// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../Helpers/applocalization.dart';
import '../Widget/custom_back_Button.dart';
import '../constant/routes.dart';
import '../constant/theme.dart';

import '../blocs/QrScan/qrscan_bloc.dart';

class QrScanPage extends StatelessWidget {
  const QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

    return BlocProvider(
      create: (_) => QrScanBloc(),
      child: Scaffold(
        appBar: AppBar(
            title: Text("QRScan".tr(context)),
            leading: const CustomBackButton()),
        body: BlocBuilder<QrScanBloc, QrScanState>(
          builder: (context, state) {
            return QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                  borderColor: ThemeColor.primaryColor,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300),
              onQRViewCreated: (QRViewController controller) {
                context.read<QrScanBloc>().add(QrScanStarted());
                controller.scannedDataStream.listen((scanData) async {
                  await controller.pauseCamera();

                  Navigator.of(context).pushNamed(AppRouting.taskDetails,
                      arguments: {'iD': scanData.code});
                  await controller.resumeCamera();
                });
              },
            );
          },
        ),
      ),
    );
  }
}
