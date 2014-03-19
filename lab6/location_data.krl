ruleset location_data {
	meta {
		name "Lab6"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging on

		provides get_location_data

		use module a169x701 alias CloudRain
    use module a41x196  alias SquareTag
	}

	dispatch {

	}

	global {
		get_location_data = function(key) {
			app:mymap{key};
		};
	}

	rule add_location_item {
		select when pds new_location_data
		pre {
			key = event:attr("key");
			value = event:attr("value");
		}
		send_directive(key) with location = value;
		fired {
			set app:mymap{"#{key}"} value;
		}
	}
}