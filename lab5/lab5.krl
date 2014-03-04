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
		fired {
			set ent:venue venue;
			set ent:city city;
			set ent:shout shout;
			set ent:createdAt createdAt;
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