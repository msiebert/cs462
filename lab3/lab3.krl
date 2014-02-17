ruleset lab3 {
	meta {
		name "Lab3"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging off
	}

	dispatch {

	}

	global {

	}

	rule show_form {
		select when pageview ".*" setting()
		pre {

		}
		{
			notify("Hello", "Hello");
		}
	}
}
