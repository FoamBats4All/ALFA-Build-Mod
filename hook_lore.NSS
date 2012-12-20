void main() {
	WriteTimestampedLogEntry( "hook_lore called" );
	SendMessageToPC( OBJECT_SELF, "You are the object." );
}