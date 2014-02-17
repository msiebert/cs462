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
			form = << 
				<form id="form">
					<label for="first">First</label>
					<input type="text" name="first"/><br />
					<label for="last">Last</label>
					<input type="text" name="last"><br />
					<input type="submit" />
				</form>
			>>;
		}
		{
			after("#main", "<strong>In the beginning the Universe was created. This has made a lot of people very angry and been widely regarded as a bad move.</strong>");
			after("#main", form);
			watch("#form", "submit");
		}
	}

	rule onclick {
		select when web submit "#form"
		pre {
			first = event:attr("first");
			last = event:attr("last");
		}
		fired {
			set ent:first first;
			set ent:last last;
		}
	}
}
