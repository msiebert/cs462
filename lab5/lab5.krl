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
			venue = response.pick("$.venue..name").decode();
			city = response.pick("$.venue..city").decode();
			shout = response.pick("$.shout").decode();
			createdAt = response.pick("$.createdAt").decode();
		} 
		fired {
			set ent:venue venue;
			set ent:city city;
			set ent:shout shout;
			set ent:createdAt createdAt;
			set ent:test response;
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
					<p>#{ent:test}</p>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
    	CloudRain:createLoadPanel("View Checkin", {}, html);
    }
	}
}