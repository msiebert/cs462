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

	rule first_rule {
		select when pageview ".*" setting ()
		pre {
		
		}
		notify("Notification:", "This is your first warning");
		notify("Notification:", "This is your second warning");
	}
}
