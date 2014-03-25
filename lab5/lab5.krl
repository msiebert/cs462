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
		subscription_map = [{
			"cid": "25751E74-B43E-11E3-85E2-4D98E71C24E1"
		}, {
			"cid": "5788719A-B43E-11E3-AF69-4D98E71C24E1"
		}];	
	}

	rule process_fs_checkin_for_pico {
		select when foursquare checkin
		foreach subscription_map setting(subscription)
		pre {
			response = event:attr("checkin");
			venue = response.decode().pick("$.venue.name").as("str");
			city = response.decode().pick("$.venue..city").as("str");
			shout = response.decode().pick("$.shout").as("str");
			createdAt = response.decode().pick("$.createdAt").as("str");
			lat = response.decode().pick("$.venue.location.lat").as("num");
			long = response.decode().pick("$.venue.location.lng").as("num");
		} 
		{
			send_directive(venue) with checkin = venue and subs = subscription;
			event:send(subscription, "location", "notification") with attrs = {
				"venue":venue,
				"city": city,
				"shout": shout,
				"createdAt": createdAt,
				"lat": lat,
				"long": long
			};
		}
	}

	rule process_fs_checkin {
		select when foursquare checkin
		pre {
			response = event:attr("checkin");
			venue = response.decode().pick("$.venue.name").as("str");
			city = response.decode().pick("$.venue..city").as("str");
			shout = response.decode().pick("$.shout").as("str");
			createdAt = response.decode().pick("$.createdAt").as("str");
			lat = response.decode().pick("$.venue.location.lat").as("num");
			long = response.decode().pick("$.venue.location.lng").as("num");
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
			set ent:lat lat;
			set ent:long long;

			raise pds event "new_location_data" for b505330x4 with key = "fs_checkin" and value = {"value": {"venue": venue, "city": city, "shout": shout, "createdAt": createdAt, "lat": lat, "long": long}};
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