% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geocode_batches.R
\name{geocode_batches}
\alias{geocode_batches}
\title{Geocode in batches}
\usage{
geocode_batches(
  .,
  batch_size = 990,
  wait_time = 4800,
  n_results = 1,
  unwrap = FALSE,
  geonames_username
)
}
\arguments{
\item{.}{data frame}

\item{batch_size}{size of each batch to geocode}

\item{wait_time}{in seconds between batches
Note:
default batch_size and wait_time were set to accomplish the geocoding task optimally within the constraints of geonames free access}

\item{n_results}{same as geocode}

\item{unwrap}{as in geocode}

\item{geonames_username}{as in geocode}
}
\value{
df geocoded
}
\description{
Geocode in batches
}
\examples{
df <- tibble::tribble(
   ~value,  ~location_word,                    ~Country,
   "mumbai region, district of seattle, sichuan province",  "mumbai","India",
   "mumbai region, district of seattle, sichuan province",  "seattle", "USA",
   "mumbai region, district of seattle, sichuan province", "sichuan",  "China, People's Republic"
   )

geocode_batches(df, batch_size = 2, wait_time = 0.4, geonames_username = "rammkripa")

}
