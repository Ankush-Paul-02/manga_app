abstract class BottomNavEvent {}

class BottomNavChange extends BottomNavEvent {
  final int index;
  BottomNavChange(this.index);
}

class BottomNavSyncWithRoute extends BottomNavEvent {
  final String location;
  BottomNavSyncWithRoute(this.location);
}
