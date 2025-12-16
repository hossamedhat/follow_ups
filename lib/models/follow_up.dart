enum FollowUpType {
  call,
  meeting,
  visit,
}

enum FollowUpStatus {
  completed,
  scheduled,
  none,
}

class FollowUp {
  final String id;
  final String title;
  final String? description;
  final FollowUpType type;
  final FollowUpStatus status;
  final String? customerName;

  const FollowUp({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.status,
    this.customerName,
  });
}


