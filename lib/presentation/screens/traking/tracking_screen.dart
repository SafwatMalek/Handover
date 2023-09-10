import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handover/data/model/order/order_status.dart';
import 'package:handover/presentation/screens/traking/tracking_bloc.dart';
import 'package:handover/presentation/widget/bottom_sheet/bottom_sheet_container.dart';
import 'package:handover/presentation/widget/bottom_sheet/review/review_view.dart';
import 'package:handover/presentation/widget/bottom_sheet/tracking/tracking_view.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late TrackingBloc _bloc;

  @override
  Widget build(BuildContext screenContext) {
    _bloc = BlocProvider.of<TrackingBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.add(InitializeMap());
    });

    return Scaffold(
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case LoadingState:
              return const Center(child: CircularProgressIndicator());
            case StartTracking:
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  //Map
                  StreamBuilder(
                      stream: _bloc.markerStream,
                      initialData: const <Marker>{},
                      builder: (_, snapshot) {
                        if (snapshot.data?.isNotEmpty == true) {
                          return GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                snapshot.data!.first.position.latitude,
                                snapshot.data!.first.position.longitude,
                              ),
                              zoom: 16.0,
                            ),
                            markers: snapshot.data!,
                          );
                        } else {
                          return Container();
                        }
                      }),
                  //Bottom Sheet
                  StreamBuilder(
                      stream: _bloc.order,
                      initialData: null,
                      builder: (_, order) {
                        if (order.data != null) {
                          if (order.data!.status !=
                              OrderStatus.delivered.value) {
                            return BottomSheetContainer(
                                order: order.data!,
                                height: 35,
                                child: TrackingView(
                                  order: order.data!,
                                ));
                          } else {
                            return BottomSheetContainer(
                                order: order.data!,
                                height: 45,
                                child: const ReviewView());
                          }
                        } else {
                          return Container();
                        }
                      })
                ],
              );
            default:
              return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }
}
