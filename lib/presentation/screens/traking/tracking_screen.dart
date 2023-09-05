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
    _bloc.add(InitializeMap());

    return Scaffold(
      body: BlocBuilder(
        bloc: BlocProvider.of<TrackingBloc>(context),
        builder: (context, state) {
          return Stack(
            children: [
              if (state is LoadingState) ...[
                const Center(child: CircularProgressIndicator())
              ] else if (state is InitialMapState) ...[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.orderModel.deliveryPoint.latitude,
                      state.orderModel.deliveryPoint.longitude,
                    ),
                    zoom: 16.0,
                  ),
                  markers: state.markers,
                ),

                // TODO Bottom Sheet
              ] else if (state is ErrorState) ...[
                const Center(
                  child: Text("Something went wrong please try again later"),
                )
              ] else ...[
                Container()
              ]
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
