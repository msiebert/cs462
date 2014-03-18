//49C702FC-AEC0-11E3-BC69-45C8E71C24E1

//curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "lat=14.001023&long=143.00405" http://cs.kobj.net/sky/event/49C702FC-AEC0-11E3-BC69-45C8E71C24E1/1/location/currnt?_rids=b505330x6

ruleset lab7 {
	meta {
		name "Lab7"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging off

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
			lat = event:attr("lat");
			long = event:attr("long");
		}
		send_directive("test") with latitude = lat and longtitude = long;
	}
}