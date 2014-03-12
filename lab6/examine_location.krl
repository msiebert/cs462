ruleset location_data {
	meta {
		name "Lab6"
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

	rule show_fs_location {
		select when web cloudAppSelected
		pre {
			result = Location:get_location_data("fs_checkin");
			html = <<
				<div class="checkin">
					<h1>Checkin Details</h1>
					<p>Venue: #{result{"venue"}}</p>
					<p>City: #{result{"city"}}</p>
					<p>Shout: #{result{"shout"}}</p>
					<p>Created At: #{result{"createdAt"}}</p>
					<p>#{result}</p>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
    	CloudRain:createLoadPanel("View Checkin", {}, html);
    }
	}
}