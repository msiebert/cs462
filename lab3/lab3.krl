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
			username = (ent:first) => ent:first + " " + ent:last | "";
			p = <<
				<p id="username">#{username}</p>
			>>;
		}
		{
			after("#main", "<strong>In the beginning the Universe was created. This has made a lot of people very angry and been widely regarded as a bad move.</strong>");
			after("#main", p);
			after("#main", form);
			watch("#form", "submit");
		}
	}

	rule onclick {
		select when web submit "#form"
		pre {
			first = event:attr("first");
			last = event:attr("last");
			username = first + " " + last;
		}
		{
			replace_inner("#username", username);
		}
		fired {
			set ent:first first;
			set ent:last last;
		}
	}

	rule clear_name {
		select when pageview ".*" setting()
		pre {
			query = page:url("query");
			shouldClear = query.match(re/clear=?/);
		}
		if shouldClear then {
			replace_inner("#username", "");
			}
		fired {
			clear ent:first if shouldClear;
			clear ent:last if shouldClear;
		}
	}
}
