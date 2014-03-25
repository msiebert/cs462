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
		}
		http:post("https://docs.google.com/forms/d/1QlfAU2501qIhF9uX2g9Nhae-nIcKzQ0-YEYR2Y5bCSQ/formResponse")
			with params = {"entry.387126572": venue, "entry.743423249": city, "entry.935139493": shout, "entry.790812745": createdAt, "submit":"Submit", "pageNumber":"0", "backupCache":""};
	}
}