import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class _Place {
  final String name;
  final LatLng point;
  const _Place(this.name, this.point);
}
// Koordinat sekitar Institut Teknologi Del, Laguboti. Silakan ganti sesuai kebutuhan.
const _places = [
  _Place('Kampus IT Del', LatLng(2.3834, 99.1480)),
  _Place('Perpustakaan', LatLng(2.3840, 99.1487)),
  _Place('Kantin', LatLng(2.3828, 99.1474)),
];
class CampusMap extends StatelessWidget {
  const CampusMap({super.key});
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(initialCenter: _places.first.point, initialZoom: 16),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'del.ac.id.pam_notes',
        ),
        MarkerLayer(
          markers: _places
              .map((p) => Marker(
                    point: p.point,
                    width: 44,
                    height: 44,
                    child: GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(p.name))),
                      child: const Icon(Icons.location_on, color: Colors.red, size: 44),
                    ),
                  ))
              .toList(),
        ),
        const RichAttributionWidget(
          attributions: [TextSourceAttribution('© OpenStreetMap contributors')],
        ),
      ],
    );
  }
}
