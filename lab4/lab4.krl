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
		query = function(query) {
			result = http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
				{
					"apikey" : "wbvuqn2kntms2kdybq46zd8p",
					"page_limit": 1,
					"page": 1,
					"q": query
				}
			).pick("$.content").decode();

			total = result.pick("$.total").as("num");
			movie = <<
				<h1>#{result.pick("$.movies[0].title")}</h1>
			>>;

			error = <<
				<h1>Not Found</h1>
				<p>Sorry, Rotten Tomatoes does not contain an entry for #{title}</p>
			>>;

			(total > 0) => movie | error;
		};
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
			after("#main", html);
			watch("#form", "submit");
		}
	}

	rule run_query {
		select when web submit "#form"
		pre {
			queryString = event:attr("movie-title")
		}
		{
			replace_inner("#movie", query(queryString))
		}
	}
}
