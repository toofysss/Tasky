part of 'qrscan_bloc.dart';

abstract class QrScanState extends Equatable {
  const QrScanState();

  @override
  List<Object?> get props => [];
}

class QrScanInitial extends QrScanState {}

class QrScanInProgress extends QrScanState {}

class QrScanSuccess extends QrScanState {
  final Barcode scanData;

  const QrScanSuccess({required this.scanData});

  @override
  List<Object?> get props => [scanData];
}

class QrScanFailure extends QrScanState {
  final String error;

  const QrScanFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
