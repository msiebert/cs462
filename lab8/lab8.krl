//ecis
//pico1 = 25751E74-B43E-11E3-85E2-4D98E71C24E1
//pico2 = 5788719A-B43E-11E3-AF69-4D98E71C24E1

ruleset lab8 {
	meta {
		name "Lab8"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging off

		use module a169x701 alias CloudRain
    use module a41x196  alias SquareTag
	}

	dispatch {

	}

	global {
		
	}

	rule location_catch {
		select when location notification
		pre {
			venue = event:attr("venue");
			city = event:attr("city");
			shout = event:attr("shout");
			createdAt = event:attr("createdAt");
			lat = event:attr("lat");
			long = event:attr("long");
		}
		send_directive("location_catch") with v = venue;
		fired {
			set app:venue venue;
			set app:city city;
			set app:shout shout;
			set app:createdAt createdAt;
			set app:lat lat;
			set app:long long;
		}
	}

	rule show_fs_location {
		select when web cloudAppSelected
		pre {
			html = <<
				<div class="checkin">
					<h1>Checkin Details</h1>
					<p>Venue: #{app:venue}</p>
					<p>City: #{app:city}</p>
					<p>Shout: #{app:shout}</p>
					<p>Created At: #{app:createdAt}</p>
					<p>Lat: #{app:lat}</p>
					<p>Long: #{app:long}</p>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
    	CloudRain:createLoadPanel("View Checkin", {}, html);
    }
	}
}