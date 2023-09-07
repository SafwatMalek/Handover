import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handover/presentation/screens/traking/tracking_bloc.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late TrackingBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<TrackingBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.add(InitializeMap());
    });

    return Scaffold(
      body: BlocBuilder(
        bloc: BlocProvider.of<TrackingBloc>(context),
        builder: (context, state) {
          var loadingWidget = (state is LoadingState)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container();

          var mapWidget = (state is UpdateMapMarkers)
              ? GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.orderModel.deliveryPoint.latitude,
                      state.orderModel.deliveryPoint.longitude,
                    ),
                    zoom: 16.0,
                  ),
                  markers: state.markers,
                )
              : Container();

          return Stack(
            children: [
              loadingWidget,
              mapWidget,
              // bottom sheet
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.add(TrackingComplete());
    super.dispose();
  }
}
