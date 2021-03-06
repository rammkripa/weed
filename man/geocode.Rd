% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geocode.R
\name{geocode}
\alias{geocode}
\title{GeoCodes text locations using the GeoNames API}
\usage{
geocode(., n_results = 1, unwrap = FALSE, geonames_username)
}
\arguments{
\item{.}{a data frame which has been locationized (see \code{weed::split_locations})}

\item{n_results}{number of lat/longs to get}

\item{unwrap}{if true, returns lat1, lat2, lng1, lng2 etc. as different columns, otherwise one lat column and 1 lng column}

\item{geonames_username}{Username for geonames API. More about getting one is in the note above.}
}
\value{
the same data frame with a lat column/columns and lng column/columns
}
\description{
Uses the \code{location_word} and \code{Country} columns of the data frame to make queries
to the geonames API and geocode the locations in the dataset.

Note:
\enumerate{
\item The Geonames API (for free accounts) limits you to 1000 queries an hour
\item You need a geonames username to make queries. You can learn more about that \href{https://www.geonames.org/manual.html}{here}
}
}
\examples{
df <- tibble::tribble(
   ~value,  ~location_word,                    ~Country,
   "mumbai region, district of seattle, sichuan province",  "mumbai","India",
   "mumbai region, district of seattle, sichuan province",  "seattle", "USA"
   )
geocode(df, n_results = 1, unwrap = TRUE, geonames_username = "rammkripa")


}
