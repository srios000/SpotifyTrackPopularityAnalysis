library(shiny)
library(readr)
library(DT)
library(plotly)
library(ggplot2)
library(dplyr)
library(shinydashboard)
library(shiny.semantic)
library(dashboardthemes)
library(shinyWidgets)

Sys.setlocale(category = "LC_ALL", locale = "ja_JP.UTF-8")


spotify_data <- read_csv("input/spotify.csv")
