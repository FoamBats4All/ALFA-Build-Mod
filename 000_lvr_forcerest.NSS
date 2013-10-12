void main() {
	object oUser = GetLastUsedBy();
	ForceRest( oUser );
	IncrementRemainingFeatUses( oUser, FEAT_BARD_SONGS );
	IncrementRemainingFeatUses( oUser, FEAT_BARD_SONGS );
	IncrementRemainingFeatUses( oUser, FEAT_BARD_SONGS );
}