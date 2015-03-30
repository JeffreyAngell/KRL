ruleset echo {
	meta {
		name "Echo server"
		description << An echo server >>
		author "Jeffrey Angell"
		logging on
		sharing on
	}
	rule hello is active {
		select when echo hello
		send_directive("say") with
			something = "Hello World";
	}
	rule message is active {
		select when echo message input "(.*)" setting(m)
		send_directive("say") with
			something = m;
	}
}
