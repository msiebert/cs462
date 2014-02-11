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
		select when web pageview
		always {
			notify("Hello World");
		}
	}
}