ruleset lab4 {
	meta {
		name "Lab4"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging off
	}

	dispatch {

	}

	global {

	}

	rule hello {
		select when pageview ".*" setting()
		{
			notify("Hello", "Test");
		}
	}
}
