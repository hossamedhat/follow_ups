import '../models/follow_up.dart';

/// Fake / mocked service to provide follow-up data.
/// This layer can be swapped later with a real API implementation.
abstract class FollowUpService {
  Future<List<FollowUp>> fetchFollowUps();
}

class MockFollowUpService implements FollowUpService {
  const MockFollowUpService();

  @override
  Future<List<FollowUp>> fetchFollowUps() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return const [
      FollowUp(
        id: 'FU-1001',
        title: 'Call with Ahmed about renewal',
        description:
            '<b>Objective:</b> Discuss renewal terms and upsell to premium plan.',
        type: FollowUpType.call,
        status: FollowUpStatus.scheduled,
        customerName: 'Ahmed Ali',
      ),
      FollowUp(
        id: 'FU-1002',
        title: 'On-site visit to main warehouse',
        description:
            'Inspect inventory system and collect feedback from operations team.',
        type: FollowUpType.visit,
        status: FollowUpStatus.completed,
        customerName: 'Mohamed Digital',
      ),
      FollowUp(
        id: 'FU-1003',
        title: 'Intro meeting with new lead',
        description:
            'Short discovery meeting to understand pain points and timeline.',
        type: FollowUpType.meeting,
        status: FollowUpStatus.none,
        customerName: 'Seif Hossam',
      ),
      FollowUp(
        id: 'FU-1004',
        title: 'Follow-up call on proposal sent',
        description:
            'Confirm that the client received the proposal and answer questions.',
        type: FollowUpType.call,
        status: FollowUpStatus.scheduled,
        customerName: 'SmartHome Plus',
      ),
      FollowUp(
        id: 'FU-1005',
        title: 'Post-implementation review',
        description:
            'Review system performance after go-live and plan next phase.',
        type: FollowUpType.meeting,
        status: FollowUpStatus.completed,
        customerName: 'CityBank',
      ),
    ];
  }
}


