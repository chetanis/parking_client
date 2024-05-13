import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_client/features/cars/data/models/car.dart';
import 'package:parking_client/features/cars/providers/car_controller.dart';
import 'package:parking_client/features/cars/providers/states/car_state.dart';
import 'package:parking_client/features/scanner/presentaion/widgets/car_list.dart';
import 'package:parking_client/features/scanner/presentaion/widgets/qr_scanner_overlay.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  QRViewController? _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool _flashOn = false;
  String _scanData = '';
  Car? selectedCar;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _getCars();
    });
  }

  Future<void> _getCars() async {
    final carController = ref.read(carControllerProvider.notifier);
    try {
      await carController.getCarDetail(['1', '2', '3']);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller!.scannedDataStream.listen((scanData) {
        setState(() {
          _scanData = scanData.code!;
        });
        _showSnackBar(context, 'Scanned Data: $_scanData');
        // Handle the scanned data as desired
      });
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onCarSelected(Car? car) {
    setState(() {
      selectedCar = car; // Update the state with the selected car
    });
  }

  @override
  Widget build(BuildContext context) {
    var carsState = ref.watch(carControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          // QR code scanner
          QRView(
            key: _qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
          Positioned(
            top: 35,
            left: 5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const UserProfilePage()),
                  // );
                },
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          ),
          Positioned(
            top: 35,
            right: 5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  _controller?.toggleFlash();
                  setState(() {
                    _flashOn = !_flashOn;
                  });
                },
                child: Icon(
                  _flashOn
                      ? Icons.flashlight_off_outlined
                      : Icons.flashlight_on_outlined,
                  color: Colors.white,
                )),
          ),
          Align(
            alignment: const Alignment(0, 0.55),
            child: CarList(
              carState: carsState,
              onSelected:
                  _onCarSelected, // Pass the callback to handle selection
            ),
          ),
        ],
      ),
    );
  }

  Widget carList(CarState carsState) {
    if (carsState is CarInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (carsState is CarLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (carsState is CarSuccess) {
      return Expanded(
        child: ListView.builder(
          itemCount: carsState.cars.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(carsState.cars[index].model),
              subtitle: Text(carsState.cars[index].licenseNumber),
            );
          },
        ),
      );
    } else if (carsState is CarFailure) {
      return Center(
        child: Text(carsState.error),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
