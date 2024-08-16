part of 'qrscan_bloc.dart';

abstract class QrScanEvent extends Equatable {
  const QrScanEvent();

  @override
  List<Object> get props => [];
}

class QrScanStarted extends QrScanEvent {}

class QrScanData extends QrScanEvent {
  final Barcode scanData;

  const QrScanData({required this.scanData});

  @override
  List<Object> get props => [scanData];
}

class QrScanError extends QrScanEvent {
  final String error;

  const QrScanError({required this.error});

  @override
  List<Object> get props => [error];
}
