ruleset location_data {
	meta {
		name "Lab6"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging off

		provides get_location_data

		use module a169x701 alias CloudRain
    use module a41x196  alias SquareTag
	}

	dispatch {

	}

	global {
		get_location_data = function(key) {
			ent:mymap{key};
		};
	}

	rule add_location_item {
		select when pds new_location_data setting(key, value)
		pre {

		}
		fired {
			set ent:mymap{"#{key}"} value;
		}
	}
}