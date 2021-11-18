## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

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

## ----message=F, warning=F-----------------------------------------------------
library(tigris)
library(sf)
library(dplyr)
library(ggplot2)

ri_tracts = tracts("RI", county="Providence", year=2020, progress_bar=FALSE)

full_join(pl, ri_tracts, by="GEOID") %>%
ggplot(aes(fill=pop, geometry=geometry)) +
    geom_sf(size=0) +
    theme_void()

