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
			after("#main", "In the beginning the Universe was created. This has made a lot of people very angry and been widely regarded as a bad move.");
			after("#main", "<form><label for='first'>First</label><input type='text' name='first'/><br /><label for='last'>Last</label><input type='text' name='last'><br /><input type='submit' id='submit-button' /></form");
			watch("#submit-button", "click");
		}
	}

	rule onclick {
		select when web click "#submit-button"
		pre {

		}
		{
			notify("notification", "you clicked");
		}
	}
}
