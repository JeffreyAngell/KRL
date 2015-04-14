ruleset song_store {
	meta {
		name "Song store"
		description << A store of songs >>
		author "Jeffrey Angell"
		logging on
		provides songs, hymns, secular_music
		sharing on
	}
	global {
		songs = function(){
			songs = ent:songs;
			songs;
		};
		hymns = function(){
			hymns = ent:hymns;
			hymns;
		};
		secular_music = function(){
			songs = ent:songs.values().difference(ent:hymns.values());
			songs;
		};
	}
	rule collect_songs {
		select when explicit sung
		pre{
			song = { time:now() : event:attr("song")};
			songs = song.put(ent:songs);
		}
		always{
			set ent:songs songs;
		}
	}
	rule collect_hymns {
		select when explicit found_hymn
		pre{
			hymn = { time:now() : event:attr("hymn")};
			hymns = hymn.put(ent:hymns);
		}
		always{
			set ent:hymns hymns;
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
