enum CandidateStatus { applied, screening, interview, offered, hired, rejected }

class RecruitmentCandidate {
  final String id;
  final String name;
  final String email;
  final String positionId;
  final CandidateStatus status;
  final String? resumeUrl;

  const RecruitmentCandidate({
    required this.id,
    required this.name,
    required this.email,
    required this.positionId,
    this.status = CandidateStatus.applied,
    this.resumeUrl,
  });
}
