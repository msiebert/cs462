//wbvuqn2kntms2kdybq46zd8p
//http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=wbvuqn2kntms2kdybq46zd8p&q=Push&page_limit=1&page=1

ruleset rotten_tomatoes {
	meta {
		name "Lab4"
		description <<
			
		>>
		author "mark.jiali.siebert"
		logging off
	}

	dispatch {

	}

	global {

	}

	rule show_page {
		select when pageview ".*" setting()
		pre {
			html = <<
				<div id="movie" style="width:70%;margin:auto"></div>
				<form method="GET" id="form">
					<input type="text" name="movie-title" placeholder="Movie Title" />
					<input type="submit" value="Search" />
				</form>
			>>;
		}
		{
			after("#main", html)
		}
	}
}
