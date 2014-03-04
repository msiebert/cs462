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

	rule display_checkin {
		select when web cloudAppSelected
		pre {
			html = <<
				<div class="checkin">
					<h1>Checkin Details</h1>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
    	CloudRain:createLoadPanel("View Checkin", {}, html);
    }
	}
}