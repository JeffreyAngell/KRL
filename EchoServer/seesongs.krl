ruleset see_songs {
	meta {
		name "See songs"
		description << A see songs something >>
		author "Jeffrey Angell"
		logging on
		sharing on
	}
	rule songs is active {
		select when echo message input "(.*)" setting(m)
		send_directive("sing") with
			song = m;
	}
}
