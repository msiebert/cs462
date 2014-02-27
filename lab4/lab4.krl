//wbvuqn2kntms2kdybq46zd8p
//http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=wbvuqn2kntms2kdybq46zd8p&q=Push&page_limit=1&page=1

ruleset rotten_tomatoes {
	meta {
		name "Lab4"
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
				<img src='#{result.pick("$.movies[0]..thumbnail")}' style="float:left" />	
				<h1>#{result.pick("$.movies[0].title")}</h1>
				<p>Release Year: #{result.pick("$.movies[0].year")}</p>
				<p>Synopsis: #{result.pick("$.movies[0].synopsis")}</p>
				<p>Critic Rating: #{result.pick("$.movies[0]..critics_rating")}</p>
				<p>Critic Consensus: #{result.pick("$.movies[0].critics_consensus")}</p>
				<p>Audience Rating: #{result.pick("$.movies[0]..audience_rating")}</p>
			>>;

			error = <<
				<h1>Not Found</h1>
				<p>Sorry, Rotten Tomatoes does not contain an entry for <strong>#{query}</strong></p>
			>>;

			(total > 0) => movie | error;
		};
	}

	rule show_page {
		select when web cloudAppSelected
		pre {
			html = <<
				<div id="movie" style="width:70%;margin:auto"></div>
				<div>
					<form method="GET" id="form">
						<input type="text" name="movie-title" placeholder="Movie Title" />
						<input type="submit" value="Search" />
					</form>
				</div>
			>>;
		}
		{
			SquareTag:inject_styling();
      CloudRain:createLoadPanel("Search Movies", {}, html);
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
