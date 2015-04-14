ruleset song_store {
	meta {
		name "Song store"
		description << A store of songs >>
		author "Jeffrey Angell"
		logging on
		sharing on
	}
	global {
		songs = function(){
			ent:songs
		};
		hymns = function(){
			ent:hymns
		};
		secular_music = function(){
			ent:songs.values().difference(ent:hymns.values());
		};
	}
	rule collect_songs {
		select when explicit sung
		pre{
			song = { time:now() : event:attr("song")};
			songs = song.put(ent:songs);
		}
	}
	rule collect_hymns {
		select when explicit found_hymn
		pre{
			hymn = { time:now() : event:attr("hymn")};
			hymns = song.put(ent:hymns);
		}
	}
	rule clear_songs {
		select when song reset
		always {
			clear ent:hymns;
			clear ent:songs;
		}
	}
}
