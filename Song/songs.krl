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
		always {
			raise explicit event 'sung'
				with song = m;
		}
	}
	rule find_hymn is active {
		select when explicit sung
			song "(.*)" setting(m)
		if m.match(re/.*god.*/i) then
			noop();
		fired {
			raise explicit event 'found_hymn'
				with hymn = m;
		}
	}
}
