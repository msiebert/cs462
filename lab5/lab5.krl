ruleset foursquare {
	meta {
		name "Lab5"
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

	rule process_fs_checkin {
		select when foursquare checkin
		pre {
			response = event:attr("checkin");
			venue = response.decode().pick("$.venue.name").as("str");
			city = response.decode().pick("$.venue..city").as("str");
			shout = response.decode().pick("$.shout").as("str");
			createdAt = response.decode().pick("$.createdAt").as("str");
		} 
		{
			send_directive(venue) with checkin = venue;
			emit <<
				console.log("Rule fired: foursquare checkin")
			>>;
		}
		fired {
			set ent:venue venue;
			set ent:city city;
			set ent:shout shout;
			set ent:createdAt createdAt;

			raise pds event "new_location_data" for b505330x4 with key = "fs_checkin" and value = {"value": {"venue": venue, "city": city, "shout": shout, "createdAt": createdAt}};
		}
	}

	rule display_checkin {
		select when web cloudAppSelected
		pre {
			html = <<
				<div class="checkin">
					<h1>Checkin Details</h1>
					<p>Venue: #{ent:venue}</p>
					<p>City: #{ent:city}</p>
					<p>Shout: #{ent:shout}</p>
					<p>Created At: #{ent:createdAt}</p>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
    	CloudRain:createLoadPanel("View Checkin", {}, html);
    }
	}
}