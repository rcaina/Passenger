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
        "status": "confirmed" // requested | confirmed
      },
      {
        "userId": "2",
        "status": "confirmed" // requested | confirmed
      }
    ]
  }
};

Map<String, dynamic> users = {
  "0": {
    "name": "Mark Johnson",
    "image": "assets/images/mark.png",
    "imageURL":
        "https://media.istockphoto.com/photos/genuine-young-latin-american-male-picture-id1183940634?k=20&m=1183940634&s=612x612&w=0&h=_7fBlbiFYfRPPIjmzvzyFd_Hdi85NhJW-Hus-Ua3EyM=",
    "phone": "123-456-7890",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "I like to listen to music and watch movies"
  },
  "1": {
    "name": "Andrew Smith",
    "image": "assets/images/mark.png",
    "imageURL":
        "https://res.cloudinary.com/highereducation/images/f_auto,q_auto/v1633456446/BestColleges.com/Colin-Weikmann_1_vosixf_1336982131/Colin-Weikmann_1_vosixf_1336982131.png?_i=AA",
    "phone": "123-456-7890",
    "about": "I am a junior at BYU studying Computer Science!",
    "interests": "I like to hike",
  },
  "2": {
    "name": "Andrea Blake",
    "image": "assets/images/andrea.jpg",
    "imageURL":
        "https://carlsonschool.umn.edu/sites/carlsonschool.umn.edu/files/Jordyn%20Tayloe_0.jpg",
    "phone": "801-904-1254",
    "about": "I love Charlie Puth",
    "interests": "Camping, Hiking"
  },
};

Map<String, dynamic> requests = {
  "0": {
    "passengerId": "0",
    "tripId": "0",
    "passengerDestination": "Austin",
    "message": "Hello. Id like to join you.",
    "passengerContribution": 50.50,
    "read": false,
  }
};

Map<String, dynamic> requestResponse = {
  "0": {
    "requestId": "0",
    "addedToTrip": true,
    "read": false,
  }
};

List<dynamic> notifications = [
  {
    "user-name": "Andrew Smith",
    "userId": "1",
    "message": "has confirmed your request to ride with them.",
    "from-location": "Austin, TX",
    "to-location": "BYU",
    "from-date": "8/28/22",
    "to-date": "8/29/22",
  },
  {
    "user-name": "Andrea Blake",
    "userId": "2",
    "message": "has denied your request to ride with them.",
    "from-location": "BYU",
    "to-location": "Irving, TX",
    "from-date": "10/30/22",
    "to-date": "10/31/22",
  }
];
