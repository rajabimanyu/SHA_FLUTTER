class MockResponseData {
  const MockResponseData._();

  static Future<void> mockApiDelay({int seconds = 2}) {
    return Future.delayed(Duration(milliseconds: 500));
  }

  static const getEnvListResponse = '''
  [
    {
        "id": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "name": "Raj"
    },
  {
        "id": "environmenta4062f2b-3686-4783-8921-e64067a36128",
        "name": "Abimanyu"
    },
  {
        "id": "environment9e6429d1-6c99-459f-8761-9663345b326a",
        "name": "Rinik"
    },
  {
        "id": "environment68abd4c0-760e-42d8-a7d2-08cfe08e0dbe",
        "name": "Santhosh"
    },
  {
        "id": "environment63c66138-2105-4f29-b1d4-6f12ae1c051d",
        "name": "Aravinth"
    }
  ]''';

  static const fetchSurroundingsListResponse = '''
  [
    {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d25",
        "name": "bedroom"
    },
  {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d26",
        "name": "kitchen"
    },
  {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d27",
        "name": "living room"
    },
  {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d28",
        "name": "master bedroom"
    },
  {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d29",
        "name": "balcony"
    },
  {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d30",
        "name": "Store room"
    },
  {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d31",
        "name": "Waiting Hall"
    },
  {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d32",
        "name": "Bedroom 1st Floor"
    },
  {
        "id": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d33",
        "name": "Bathroom"
    }
]''';

  static const surroundingBedroom = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d25",
    "id": "devicenew1",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "FAN",
        "status": "OFF",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "devicenew1"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing_bulb_bedroom",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "devicenew1"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ar",
        "thingType": "PLUG",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "devicenew1"
      }
    ]
  },
  {
  "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
  "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d25",
  "id": "device12w3",
  "things": [
  {
  "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
  "id": "thing75d07515-8370-4e50-94b6-c74232f379td",
  "thingType": "FAN",
  "status": "ON",
  "totalStep": 5,
  "currentStep": 2,
  "lastUpdatedTime": 1693044552412,
  "deviceID": "device12w3"
  },
  {
  "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
  "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ic",
  "thingType": "PLUG",
  "status": "ON",
  "totalStep": 5,
  "currentStep": 2,
  "lastUpdatedTime": 1693044552710,
  "deviceID": "device12w3"
  }
  ]
}
]''';

  static const surroundingKitchen = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d26",
    "id": "devicekitchen1",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "FAN",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "devicekitchen1"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ac",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "devicekitchen1"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ar",
        "thingType": "PLUG",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "devicekitchen1"
      }
    ]
  }
  ]''';

  static const surroundingLiving = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d27",
    "id": "deviceliving78",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "FAN",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "deviceliving78"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ac",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceliving78"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ar",
        "thingType": "PLUG",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceliving78"
      }
    ]
  }
  ]''';


  static const surroundingMaster = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d28",
    "id": "deviceMaster8",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "FAN",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "deviceMaster8"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ac",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceMaster8"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ae",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceMaster8"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ar",
        "thingType": "PLUG",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceMaster8"
      }
    ]
  }
  ]''';

  static const surroundingBalcony = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d29",
    "id": "deviceBalcony5",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "FAN",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "deviceBalcony5"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ac",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceBalcony5"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ae",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceBalcony5"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ar",
        "thingType": "PLUG",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceBalcony5"
      }
    ]
  }
  ]''';

  static const surroundingStore = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d30",
    "id": "deviceStore",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "FAN",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "deviceStore"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ac",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceStore"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ae",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceStore"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ar",
        "thingType": "PLUG",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceStore"
      }
    ]
  }
  ]''';


  static const surroundingWaiting = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d31",
    "id": "deviceWaiting",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "FAN",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "deviceWaiting"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ac",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceWaiting"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c73232f3799d",
        "thingType": "FAN",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "deviceWaiting"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6arfda8d55ae",
        "thingType": "BULB",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceWaiting"
      },
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing6c7ff4b4-fa2d-4b6b-8429-6a2fda8d55ar",
        "thingType": "PLUG",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552710,
        "deviceID": "deviceWaiting"
      }
    ]
  }
  ]''';


  static const surroundingBedFirst = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d32",
    "id": "deviceFirst",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "FAN",
        "status": "ON",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "deviceFirst"
      }
    ]
  }
  ]''';

  static const surroundingBathroom = '''
  [
  {
    "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "surroundingID": "surrounding1611f5eb-a9ee-410e-9cbe-7294111a6d33",
    "id": "deviceBathroom",
    "things": [
      {
        "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "id": "thing75d07515-8370-4e50-94b6-c74232f3799d",
        "thingType": "PLUG",
        "status": "OFF",
        "totalStep": 5,
        "currentStep": 2,
        "lastUpdatedTime": 1693044552412,
        "deviceID": "deviceFirst"
      }
    ]
  }
  ]''';

  static const toggleBulbStatusOFF = '''
  {  
  "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "id": "thing_bulb_bedroom",
    "thingType": "BULB",
    "status": "OFF",
    "totalStep": 5,
    "currentStep": 2,
    "lastUpdatedTime": 1693067689061,
    "deviceID": "devicenew1"
    }
  ''';

  static const toggleBulbStatusON = '''
  {  
  "environmentID": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "id": "thing_bulb_bedroom",
    "thingType": "BULB",
    "status": "ON",
    "totalStep": 5,
    "currentStep": 2,
    "lastUpdatedTime": 1693067689099,
    "deviceID": "devicenew1"
    }
  ''';
}
