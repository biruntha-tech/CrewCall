import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationPicker extends StatefulWidget {
  final Function(String) onLocationSelected;
  
  const LocationPicker({super.key, required this.onLocationSelected});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showError('Location services are disabled');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showError('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showError('Location permissions are permanently denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.locality}, ${place.administrativeArea}, ${place.country}';
        widget.onLocationSelected(address);
        Navigator.pop(context);
      }
    } catch (e) {
      _showError('Error getting location: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Location'),
      content: SizedBox(
        width: 350,
        height: 300,
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter city, venue, or address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _getCurrentLocation,
              icon: _isLoading 
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
              label: Text(_isLoading ? 'Getting location...' : 'Use Current Location'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
            ),
            
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            
            const Text('Popular Locations:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            
            Expanded(
              child: ListView(
                children: [
                  'New York, NY',
                  'Los Angeles, CA',
                  'Chicago, IL',
                  'Houston, TX',
                  'Phoenix, AZ',
                  'Philadelphia, PA',
                ].map((location) => ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(location),
                  onTap: () {
                    widget.onLocationSelected(location);
                    Navigator.pop(context);
                  },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_searchController.text.isNotEmpty) {
              widget.onLocationSelected(_searchController.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Use Entered Location'),
        ),
      ],
    );
  }
}