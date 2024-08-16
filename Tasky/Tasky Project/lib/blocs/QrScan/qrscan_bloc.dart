import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
part 'qrscan_event.dart';
part 'qrscan_state.dart';

class QrScanBloc extends Bloc<QrScanEvent, QrScanState> {
  QrScanBloc() : super(QrScanInitial()) {
    on<QrScanData>(_onQrScanData);
    on<QrScanError>(_onQrScanError);
  }

  void _onQrScanData(QrScanData event, Emitter<QrScanState> emit) {
    emit(QrScanSuccess(scanData: event.scanData));
  }

  void _onQrScanError(QrScanError event, Emitter<QrScanState> emit) {
    emit(QrScanFailure(error: event.error));
  }
}
