class MockResponseData {
  const MockResponseData._();

  static Future<void> mockApiDelay({int seconds = 2}) {
    return Future.delayed(Duration(seconds: seconds));
  }

  static const getEnvListResponse = '''
  [
    {
        "id": "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
        "name": "bedroom"
    },
  {
        "id": "environmenta4062f2b-3686-4783-8921-e64067a36128",
        "name": "kitchen"
    },
  {
        "id": "environment9e6429d1-6c99-459f-8761-9663345b326a",
        "name": "living room"
    },
  {
        "id": "environment68abd4c0-760e-42d8-a7d2-08cfe08e0dbe",
        "name": "master bedroom"
    },
  {
        "id": "environment63c66138-2105-4f29-b1d4-6f12ae1c051d",
        "name": "balcony"
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




}
