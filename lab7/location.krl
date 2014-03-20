//49C702FC-AEC0-11E3-BC69-45C8E71C24E1

//curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "lat=14.001023&long=143.00405" http://cs.kobj.net/sky/event/49C702FC-AEC0-11E3-BC69-45C8E71C24E1/1/location/currnt?_rids=b505330x6

ruleset lab7 {
	meta {
		name "Lab7"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging on

		use module b505330x4 alias Location
		use module a169x701 alias CloudRain
    use module a41x196  alias SquareTag
	}

	dispatch {

	}

	global {
		
	}

	rule nearby {
		select when location currnt
		pre {
			lata = event:attr("lat").as("num");
			longa = event:attr("long").as("num");
			
			checkin = Location:get_location_data("fs_checkin");
			latb = checkin.pick("$..lat").as("num");
			longb = checkin.pick("$..long").as("num");

			//convert to distance
			r90 = math:pi()/2;      
			rEk = 6378;
			rlata = math:deg2rad(lata);
			rlonga = math:deg2rad(longa);
			rlatb = math:deg2rad(latb);
			rlongb = math:deg2rad(longb);
			distance = math:great_circle_distance(rlnga, r90 - rlata, rlngb, r90 - rlatb, rEk);
		}
		if distance < 5 then
		{
			send_directive("nearby") with latitude = lat and longtitude = long and raised_event = "nearby";	
		}
		fired {
			raise explicit event "location_nearby" for b505330x6 with distance = distance;
		}
		else {
			raise explicit event "location_far" for b505330x6 with distance = distance;
		}
	}

	rule is_nearby {
		select when explicit nearby 
			pre {
				distance = event:attr("distance");
			}
			send_directive("test") with distance = distance;
	}
}