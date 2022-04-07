String currentUserId = "driver-0";

//myTips = trips["driverUserId"] == currentUserId || tris["passenger"].contains("userId" == currentUserId)

Map<String, dynamic> trips = {
  "0": {
    "driverUserId": "driver-0",
    "startLocation": "BYU, Provo, UT",
    "destination": "Austin, TX",
    "departureDateTime": "4/21/22",
    "arrivalDateTime": "4/22/22",
    "availableSeats": 2,
    "passengerCost": 75,
    "passengers": [
      {
        "userId": "passenger-0",
        "status": "confirmed", // requested | confirmed
        "destination": "Amarillo, Tx"
      },
      {
        "userId": "passenger-1",
        "status": "requested", // requested | confirmed
        "destination": "Dallas, Tx"
      }
    ]
  },
  "1": {
    "driverUserId": "driver-1",
    "startLocation": "BYU, Provo, UT",
    "destination": "San Diego, CA",
    "departureDateTime": "4/21/22",
    "arrivalDateTime": "4/22/22",
    "availableSeats": 3,
    "passengerCost": 50.00,
    "passengers": [
      {
        "userId": "passenger-0",
        "status": "confirmed", // requested | confirmed
        "destination": "Las Vegas, NV"
      },
      {
        "userId": "passenger-1",
        "status": "confirmed", // requested | confirmed
        "destination": "Los Angeles, CA"
      }
    ]
  },
  "2": {
    "driverUserId": "driver-2",
    "startLocation": "BYU, Provo, UT",
    "destination": "Fresno, CA",
    "departureDateTime": "8/21/22",
    "arrivalDateTime": "8/21/22",
    "availableSeats": 3,
    "passengerCost": 50.00,
    "passengers": []
  },
  "3": {
    "driverUserId": "driver-3",
    "startLocation": "BYU, Provo, UT",
    "destination": "Portland, OR",
    "departureDateTime": "8/21/22",
    "arrivalDateTime": "8/21/22",
    "availableSeats": 2,
    "passengerCost": 50.00,
    "passengers": []
  },
  "4": {
    "driverUserId": "passenger-2",
    "startLocation": "BYU, Provo, UT",
    "destination": "Seatle, WA",
    "departureDateTime": "8/21/22",
    "arrivalDateTime": "8/21/22",
    "availableSeats": 3,
    "passengerCost": 50.00,
    "passengers": []
  }
};

Map<String, dynamic> users = {
  "driver-0": {
    "name": "Mark Johnson",
    "image": "assets/images/mark.png",
    "phone": "123-456-7890",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "I like to listen to music and watch movies"
  },
  "driver-1": {
    "name": "Andrew Smith",
    "image": "assets/images/andrew.png",
    "phone": "123-456-7890",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "I like to hike",
  },
  "driver-2": {
    "name": "Andrea Blake",
    "image": "assets/images/andrea.jpg",
    "phone": "801-904-1254",
    "about": "I love Charlie Puth",
    "interests": "Camping, Hiking"
  },
  "driver-3": {
    "name": "Obi-Wan Kenobi",
    "image": "assets/images/obi-wan.jpg",
    "phone": "801-890-1331",
    "about": "I am a Jedi and I trained Darth Vader",
    "interests": "Using the force, Jedi Temple"
  },
  "passenger-0": {
    "name": "Megan Farnsworth",
    "image": "assets/images/megan.png",
    "phone": "801-890-1331",
    "about": "I like animals",
    "interests": "Dogs, cats, horses"
  },
  "passenger-1": {
    "name": "Rick Stanley",
    "image": "assets/images/rick.png",
    "phone": "801-890-1331",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "Movies, board games, skiing"
  },
  "passenger-2": {
    "name": "Tony Harper",
    "image": "assets/images/tony.png",
    "phone": "801-890-1331",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "Movies, board games, skiing"
  },
};

Map<String, dynamic> requests = {
  "0": {
    "passengerId": "passenger-1",
    "tripId": "0",
    "passengerDestination": "Dallas, Tx",
    "message": "Hello. Id like to join you.",
    "passengerContribution": 50.50,
    "status": "requested", // requested, confirmed, or denied
    "read": false,
  },
  "1": {
    "passengerId": "passenger-0",
    "tripId": "1",
    "passengerDestination": "Las Vegas, NV",
    "message": "Hello. Can you take me to Las Vegas?",
    "passengerContribution": 50.00,
    "status": "denied", // requested, confirmed, or denied
    "read": false,
  },
  "2": {
    "passengerId": "passenger-1",
    "tripId": "2",
    "passengerDestination": "Los Angeles, CA",
    "message": "Hello. Can you take me to Los Angeles?",
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

// Dummy request that can be added during demo
Map<String, dynamic> requestsToJoinAustinTrip = {
  "joinAustinTrip-0": {
    "passengerId": "passenger-0",
    "tripId": "0",
    "passengerDestination": "Dallas, TX",
    "message": "Hello. Id like to join you.",
    "passengerContribution": 50.50,
    "status": "requested", // requested, confirmed, or denied
    "read": false,
  },
  "joinAustinTrip-1": {
    "passengerId": "passenger-1",
    "tripId": "0",
    "passengerDestination": "Amarillo, TX",
    "message": "Hello. Can you take me to Amarillo?",
    "passengerContribution": 50.00,
    "status": "requested", // requested, confirmed, or denied
    "read": false,
  },
  "joinAustinTrip-2": {
    "passengerId": "passenger-3",
    "tripId": "0",
    "passengerDestination": "Santa Fe, NM",
    "message": "Hello. Can you take me to Santa Fe?",
    "passengerContribution": 50.00,
    "status": "requested", // requested, confirmed, or denied
    "read": false,
  }
};
