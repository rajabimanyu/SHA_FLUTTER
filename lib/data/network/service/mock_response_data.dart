class MockResponseData {
  const MockResponseData._();

  static Future<void> mockApiDelay({int seconds = 2}) {
    return Future.delayed(Duration(seconds: seconds));
  }

  static const getEnvListResponse = '''
  [
    "environmentc2e0e555-9573-468a-9c7f-a866c3cfd430",
    "environmenta4062f2b-3686-4783-8921-e64067a36128",
    "environment9e6429d1-6c99-459f-8761-9663345b326a",
    "environment68abd4c0-760e-42d8-a7d2-08cfe08e0dbe",
    "environment63c66138-2105-4f29-b1d4-6f12ae1c051d",
    "environment5bdfec6a-de53-40c2-b44f-733f9dee7e32",
    "environment24fd26d5-5206-4ae8-b3cf-2a21fcbd2d90",
    "environment24f3f967-b7ad-4c07-b175-28d568c18615",
    "environment2408a172-4c79-46fd-aaa3-3afe567cce54",
    "environment1d4cdaa1-39f0-413e-abce-450f68bdb29a"
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

  static const getEnvFromUuid = '''
  {
    "id": "environmentcaaaf161-f51c-450d-b07a-41e28f733d95",
    "name": "10"
  }
  ''';


}
