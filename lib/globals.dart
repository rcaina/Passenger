int currentUserId = 0;

//myTips = trips["driverUserId"] == currentUserId || tris["passenger"].contains("userId" == currentUserId)

Map<String, dynamic> trips = {
  "0": {
    "driverUserId": "0",
    "startLocation": "BYU, Provo, UT",
    "destination": "",
    "departureDateTime": "",
    "arrivalDateTime": "",
    "availableSeats": 0,
    "passengerCost": 10.1,
    "passengers": [
      {
        "userId": 1,
        "status": "requested" // requested | confirmed
      }
    ]
  }
};

Map<String, dynamic> users = {
  "0": {
    "name": "Mark Johnson",
    "image": "assets/images/mark.png",
    "phone": "123-456-7890",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "I like to listen to music and watch movies"
  },
  "1": {
    "name": "Andrew Smith",
    "image": "assets/images/mark.png",
    "phone": "123-456-7890",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "I like to hike",
  }
};

Map<String, dynamic> requests = {
  "0": {
    "passengerId": "0",
    "tripId": 0,
    "passengerDestination": "Austin",
    "message": "Hello. Id like to join you.",
    "passengerContribution": 50.50,
    "read": false,
  }
};

Map<String, dynamic> requestResponse = {
  "0": {
    "requestId": 0,
    "addedToTrip": true,
    "read": false,
  }
};
