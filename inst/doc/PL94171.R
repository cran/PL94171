## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(tinytiger.curl_quiet=TRUE)

## ----setup, message=F, warning=F----------------------------------------------
library(PL94171)

## -----------------------------------------------------------------------------
# `extdata/ri2018_2020Style.pl` is a directory with the four P.L. 94-171 files
path <- system.file("extdata/ri2018_2020Style.pl", package = "PL94171")
pl_raw <- pl_read(path)
# try `pl_read(pl_url("RI", 2010))`

## -----------------------------------------------------------------------------
head(pl_raw$`00003`)

## -----------------------------------------------------------------------------
print(pl_geog_levels)

## -----------------------------------------------------------------------------
pl <- pl_subset(pl_raw, sumlev="140")
print(dim(pl))

## -----------------------------------------------------------------------------
pl <- pl_select_standard(pl, clean_names = TRUE)
print(pl)

## ----message=F, warning=F, eval = FALSE---------------------------------------
#  library(tinytiger)
#  library(sf)
#  library(dplyr)
#  library(ggplot2)
#  
#  ri_tracts = tt_tracts("RI", county="Providence", year=2020)

## ---- echo = FALSE------------------------------------------------------------
library(tinytiger)
library(sf)
library(dplyr)
library(ggplot2)
with_retry <- function(fn, ..., max_iter = 5) {
    out <- NULL
    i <- 1
    try({out <- fn(...)}, silent = TRUE)
    while (i <= max_iter && is.null(out)) {
        Sys.sleep(0.5)
        try({out <- fn(...)}, silent = TRUE)
        i <- i + 1
    } 
    out
}

ri_tracts = with_retry(fn = tt_tracts, state = "RI", county = "Providence", year = 2020)

## ---- eval = !is.null(ri_tracts)----------------------------------------------
full_join(pl, ri_tracts, by="GEOID") %>%
ggplot(aes(fill=pop, geometry=geometry)) +
    geom_sf(size=0) +
    theme_void()

