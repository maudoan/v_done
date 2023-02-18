// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:one_assets/one_assets.dart';
// import 'package:one_components/one_components.dart';

// class OneQRCode extends StatefulWidget {
//   const OneQRCode({
//     Key? key,
//     this.title,
//     this.description,
//     this.onResult,
//     this.formatsAllowed = const <BarcodeFormat>[],
//   }) : super(key: key);

//   final String? title;
//   final String? description;
//   final ValueChanged<String?>? onResult;

//   /// Use [formatsAllowed] to specify which formats needs to be scanned.
//   final List<BarcodeFormat>? formatsAllowed;

//   @override
//   _OneQRCodeState createState() => _OneQRCodeState();
// }

// class _OneQRCodeState extends State<OneQRCode> {
//   QRViewController? _controller;
//   Barcode? result;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Column(
//           children: [
//             OneAppBar(title: widget.title ?? 'Quét mã'),
//             Expanded(child: _buildBody(context)),
//           ],
//         ),
//       ),
//     );
//   }

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       _controller?.pauseCamera();
//     } else if (Platform.isIOS) {
//       _controller?.resumeCamera();
//     }
//   }

//   Widget _buildBody(BuildContext context) {
//     return Stack(
//       children: [
//         _buildQrView(context),
//         if (widget.description != null) _buildMoTa(context),
//       ],
//     );
//   }

//   Widget _buildMoTa(BuildContext context) {
//     return Container(
//       color: OneColors.bgQRCode.withAlpha(70),
//       padding: const EdgeInsets.only(
//         top: 20,
//         bottom: 20,
//         left: 50,
//         right: 50,
//       ),
//       child: Text(
//         widget.description ?? '',
//         style: OneTheme.of(context).title1.copyWith(color: Colors.white),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     // final scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
//     final scanArea = min(MediaQuery.of(context).size.width * 0.7, MediaQuery.of(context).size.height * 0.7);
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       //TO DO : đổi scanArea thành horizontal đối với barcode
//       overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
//       formatsAllowed: widget.formatsAllowed!,
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     bool scanned = false;
//     setState(() {
//       _controller = controller;
//     });
//     //  _controller!.scanInvert(true);
//     if (mounted) {
//       _controller?.pauseCamera();
//       _controller?.resumeCamera();
//     }
//     _controller?.scannedDataStream.listen((scanData) {
//       if (!scanned) {
//         scanned = true;
//         Navigator.of(context).pop();
//         if (widget.onResult != null) {
//           widget.onResult!(scanData.code);
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
// }
