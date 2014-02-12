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

			query = page:url("query");
			name = getName(query);
		}
		{
			notify("Hello", "Hello " + name);
		}
	}

	//rule FiveTimes {
		//select when pageview ".*" setting()
		//pre {
			//number = ent:count + 1;
		//}
		//if number < 6 then
		//	notify("Count", "count");
		//{
		//	ent:count += 1 from 1;
		//	notify("Count", number);
		//}
	//}

	rule Count {
    select when pageview ".*" setting()
    pre {
      query = page:url("query");
      hasClear = query.match(re#(&|^)clear(=|$)#);
      num = hasClear => 1 | ent:count + 1;
    }
    if num < 6 then 
      notify("Count rule", num);
    always {
      ent:count += 1 from 1;
      clear ent:count if hasClear;
    }
  }
}
}
