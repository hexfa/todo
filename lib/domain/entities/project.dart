class Project {
  final String id;
  final String name;
  final int commentCount;
  final int order;
  final String color;
  final bool isShared;
  final bool isFavorite;
  final String? parentId;
  final bool isInboxProject;
  final bool isTeamInbox;
  final String viewStyle;
  final String url;

  Project({
    required this.id,
    required this.name,
    required this.commentCount,
    required this.order,
    required this.color,
    required this.isShared,
    required this.isFavorite,
    this.parentId,
    required this.isInboxProject,
    required this.isTeamInbox,
    required this.viewStyle,
    required this.url,
  });
}
