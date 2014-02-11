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
		select when pageview ".*"
		always {
			notify("Hello World");
		}
	}
}