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
				name = queryString.extract(re/name=([^&]+)/g);
				(name.length() > 0) => name[0] | "Monkey";
			};

			query = url:page("query");
			count = query.extract(re/name=([^&]+)/g).length();
			name = getName(query);
		}
		{
			notify("Hello", "Hello " + name);
			notify("Count", count);
		}
	}
}
