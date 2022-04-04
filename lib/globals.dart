String currentUserId = "0";

//myTips = trips["driverUserId"] == currentUserId || tris["passenger"].contains("userId" == currentUserId)

Map<String, dynamic> trips = {
  "0": {
    "driverUserId": "0",
    "startLocation": "BYU, Provo, UT",
    "destination": "Austin, TX",
    "departureDateTime": "4/21/22",
    "arrivalDateTime": "4/22/22",
    "availableSeats": 2,
    "passengerCost": 70.50,
    "passengers": [
      {
        "userId": "1",
        "status": "confirmed", // requested | confirmed
        "destination": "Amarillo, Tx"
      },
      {
        "userId": "2",
        "status": "requested", // requested | confirmed
        "destination": "Dallas, Tx"
      }
    ]
  },
  "1": {
    "driverUserId": "1",
    "startLocation": "BYU, Provo, UT",
    "destination": "San Diego, CA",
    "departureDateTime": "4/21/22",
    "arrivalDateTime": "4/22/22",
    "availableSeats": 3,
    "passengerCost": 50.00,
    "passengers": [
      {
        "userId": "3",
        "status": "confirmed", // requested | confirmed
        "destination": "Las Vegas, NV"
      },
      {
        "userId": "2",
        "status": "confirmed", // requested | confirmed
        "destination": "Los Angeles, CA"
      }
    ]
  },
  "2": {
    "driverUserId": "2",
    "startLocation": "BYU, Provo, UT",
    "destination": "San Diego, CA",
    "departureDateTime": "8/21/22",
    "arrivalDateTime": "8/21/22",
    "availableSeats": 3,
    "passengerCost": 50.00,
    "passengers": []
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
    "image": "assets/images/andrew.png",
    "phone": "123-456-7890",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "I like to hike",
  },
  "2": {
    "name": "Andrea Blake",
    "image": "assets/images/andrea.jpg",
    "phone": "801-904-1254",
    "about": "I love Charlie Puth",
    "interests": "Camping, Hiking"
  },
  "3": {
    "name": "Obi-Wan Kenobi",
    "image": "assets/images/obi-wan.jpg",
    "phone": "801-890-1331",
    "about": "I am a Jedi and I trained Darth Vader",
    "interests": "Using the force, Jedi Temple"
  },
};

Map<String, dynamic> requests = {
  "0": {
    "passengerId": "2",
    "tripId": "0",
    "passengerDestination": "Dallas, Tx",
    "message": "Hello. Id like to join you.",
    "passengerContribution": 50.50,
    "status": "requested", // requested, confirmed, or denied
    "read": false,
  },
  "1": {
    "passengerId": "0",
    "tripId": "1",
    "passengerDestination": "Saint George, UT",
    "message": "Hello. Can you take me to Saint George?",
    "passengerContribution": 50.00,
    "status": "denied", // requested, confirmed, or denied
    "read": false,
  },
  "2": {
    "passengerId": "0",
    "tripId": "2",
    "passengerDestination": "Saint George, UT",
    "message": "Hello. Can you take me to Saint George?",
    "passengerContribution": 50.00,
    "status": "confirmed", // requested, confirmed, or denied
    "read": false,
  }
};

Map<String, dynamic> requestResponses = {
  "0": {
    "requestId": "0",
    "addedToTrip": true,
    "read": false,
  },
  "1": {
    "requestId": "1",
    "addedToTrip": false,
    "read": false,
  },
  "2": {
    "requestId": "2",
    "addedToTrip": true,
    "read": false,
  }
};

String destination = "";
