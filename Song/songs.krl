ruleset see_songs {
	meta {
		name "See songs"
		description << A see songs something >>
		author "Jeffrey Angell"
		logging on
		sharing on
	}
	rule songs is active {
		select when echo message
			msg_type "song"
			input "(.*)" setting(m)
		send_directive("read_song") with
			name = m;
		fired {
			raise explicit event 'sung'
				with song = m;
		}
	}
	rule find_hymn is active {
		select when explicit sung
			song "(.*god.*)" setting(m)
		send_directive("found_hymn") with
			hymn = m;
		fired {
			raise explicit event 'found_hymn'
				with hymn = m;
		}
	}
}
