ruleset Lab2 {
	meta {
		name "Lab2"
		description <<
			Lab2 for CS462
		>>
		author "Mark Siebert"
		logging off
	}
	global {

	}
	
	rule HelloWorld {
		select when pageview
		pre {
			x = 10;
		}
		if (x > 5) then {
			notify("Hello World");
		}
	}
}