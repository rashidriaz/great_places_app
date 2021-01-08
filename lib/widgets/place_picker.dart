import 'package:flutter/material.dart';
import 'package:great_places_app/Screens/map_screen.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:location/location.dart';

class PlacePicker extends StatefulWidget {
  @override
  _PlacePickerState createState() {
    return _PlacePickerState();
  }
}

class _PlacePickerState extends State<PlacePicker> {
  String _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
            "No Location Chosen",
            textAlign: TextAlign.center,
          )
              : Image.network(
            _previewImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          alignment: Alignment.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              textColor: Theme
                  .of(context)
                  .primaryColor,
              onPressed: _getUserCurrentLocation,),
            FlatButton.icon(icon: Icon(Icons.map),
              label: Text("Select on map"),
              textColor: Theme
                  .of(context)
                  .primaryColor,
              onPressed: _selectOnMap,),
          ],
        ),
      ],
    );
  }

  Future<void> _getUserCurrentLocation() async {
    final locationData = await Location().getLocation();
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(longitude: locationData.longitude, lattitude: locationData.latitude);
    setState(() {

      _previewImageUrl = staticMapUrl;
    });
  }
  Future<void> _selectOnMap() async {
    final _selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if(_selectedLocation == null){
      return;
    }
  }
}
