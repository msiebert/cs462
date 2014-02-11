ruleset a2293x2 {
	meta {
		name "Lab2"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging off
	}

	dispatch {
		// domain "exampley.com"
	}

	global {

	}

	rule Notifications {
		select when pageview ".*" setting ()
		pre {
		
		} {		
			notify("Notification:", "This is your first warning");
			notify("Notification:", "This is your second warning");
		}
	}

	rule HelloMonkey {
		select when pageview ".*" setting()
		pre {
			
			getName = function(queryString) {
				name = queryString.match(re/name=[^&]*/) => queryString.extract(re/name=([^&]*)/) | ["Monkey"];
				name[0];
			};

			query = url:page("query");
			name = getName(query);
		}
		{
			notify("Hello", "Hello " + name)
		}
	}
}
