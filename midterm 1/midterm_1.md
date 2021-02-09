---
title: "Midterm 1"
author: "Natascha Paxton"
date: "2021-02-09"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Be sure to **add your name** to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 12 total questions.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by **12:00p on Thursday, January 28**.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
library(janitor)
```

## Questions
**1. (2 points) Briefly explain how R, RStudio, and GitHub work together to make work flows in data science transparent and repeatable. What is the advantage of using RMarkdown in this context?**  
R Studio is a graphical user interface which allows for people to more easily interact with the programming language R, via a simple and intuitive interface. Github is a platform useful to programmers, that allows them to conveniently share and work on code together. One can easily push and pull R code that they work on via RStudio to and from Github, and it's easy to track changes! 

**2. (2 points) What are the three types of `data structures` that we have discussed? Why are we using data frames for BIS 15L?**
We've discussed vectors, data matrices, and data frames. We're using data frames in this class because they are most like spreadsheets, which is how most people are organizing data. The function data.frame() creates data frames, tightly coupled collections of variables which share many of the properties of matrices and of lists, used as the fundamental data structure by most of R's modeling software.

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

**3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.**

```r
elephants <- readr::read_csv("data/ElephantsMF.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   Age = col_double(),
##   Height = col_double(),
##   Sex = col_character()
## )
```

```r
elephants
```

```
## # A tibble: 288 x 3
##      Age Height Sex  
##    <dbl>  <dbl> <chr>
##  1   1.4   120  M    
##  2  17.5   227  M    
##  3  12.8   235  M    
##  4  11.2   210  M    
##  5  12.7   220  M    
##  6  12.7   189  M    
##  7  12.2   225  M    
##  8  12.2   204  M    
##  9  28.2   266. M    
## 10  11.7   233  M    
## # … with 278 more rows
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17, …
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204.00…
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M…
```


**4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.**

```r
elephants <- rename(elephants, age="Age", height="Height", sex="Sex")
```

```r
names(elephants)
```

```
## [1] "age"    "height" "sex"
```


```r
sex <- as.factor("sex")
class(sex)
```

```
## [1] "factor"
```


<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue">
**5. (2 points) How many male and female elephants are represented in the data?**

```r
elephants %>% 
  filter(sex == "M")
```

```
## # A tibble: 138 x 3
##      age height sex  
##    <dbl>  <dbl> <chr>
##  1   1.4   120  M    
##  2  17.5   227  M    
##  3  12.8   235  M    
##  4  11.2   210  M    
##  5  12.7   220  M    
##  6  12.7   189  M    
##  7  12.2   225  M    
##  8  12.2   204  M    
##  9  28.2   266. M    
## 10  11.7   233  M    
## # … with 128 more rows
```

```r
elephants %>% 
  filter(sex == "F")
```

```
## # A tibble: 150 x 3
##      age height sex  
##    <dbl>  <dbl> <chr>
##  1 11.1   218.  F    
##  2  2.33  133.  F    
##  3  2.42  145.  F    
##  4 26.5   206.  F    
##  5 11.8   207   F    
##  6  0.33   85.6 F    
##  7 26.8   227.  F    
##  8 13.4   203   F    
##  9 28.4   228.  F    
## 10  2.08  131.  F    
## # … with 140 more rows
```
138 males and 150 females. 

_While your answer here is correct, I think you know some better ways at getting at this question. If you were preparing this report for an employer, for example, you probably want to present a table that shows the counts- not the number of rows._


```r
elephants %>% count(sex)
```

```
## # A tibble: 2 x 2
##   sex       n
## * <chr> <int>
## 1 F       150
## 2 M       138
```

</div>

**6. (2 points) What is the average age all elephants in the data?**


```r
  mean(elephants$age, na.rm = T)
```

```
## [1] 10.97132
```

**7. (2 points) How does the average age and height of elephants compare by sex?**

```r
elephants %>% 
  group_by(sex) %>% 
  summarise(avg_age = mean(age),
            avg_height = mean(height))
```

```
## # A tibble: 2 x 3
##   sex   avg_age avg_height
## * <chr>   <dbl>      <dbl>
## 1 F       12.8        190.
## 2 M        8.95       185.
```

**8. (2 points) How does the average height of elephants compare by sex for individuals over 25 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.**

```r
elephants %>% 
  filter(age > 25) %>% 
  group_by(sex) %>% 
  summarise(avg_height = mean(height), 
            min_height = min(height), 
            max_height = max(height), n_total = n())
```

```
## # A tibble: 2 x 5
##   sex   avg_height min_height max_height n_total
## * <chr>      <dbl>      <dbl>      <dbl>   <int>
## 1 F           233.       206.       278.      25
## 2 M           273.       237.       304.       8
```
For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

**9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.**

```r
vertebrate_community_composition<- readr::read_csv("data/IvindoData_DryadVersion.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   HuntCat = col_character(),
##   LandUse = col_character()
## )
## ℹ Use `spec()` for the full column specifications.
```

```r
vertebrate_community_composition
```

```
## # A tibble: 24 x 26
##    TransectID Distance HuntCat NumHouseholds LandUse Veg_Rich Veg_Stems
##         <dbl>    <dbl> <chr>           <dbl> <chr>      <dbl>     <dbl>
##  1          1     7.14 Modera…            54 Park        16.7      31.2
##  2          2    17.3  None               54 Park        15.8      37.4
##  3          2    18.3  None               29 Park        16.9      32.3
##  4          3    20.8  None               29 Logging     12.4      29.4
##  5          4    16.0  None               29 Park        17.1      36  
##  6          5    17.5  None               29 Park        16.5      29.2
##  7          6    24.1  None               29 Park        14.8      31.2
##  8          7    19.8  None               54 Logging     13.2      32.6
##  9          8     5.78 High               25 Neither     12.6      23.7
## 10          9     5.13 High               73 Logging     16        27.1
## # … with 14 more rows, and 19 more variables: Veg_liana <dbl>, Veg_DBH <dbl>,
## #   Veg_Canopy <dbl>, Veg_Understory <dbl>, RA_Apes <dbl>, RA_Birds <dbl>,
## #   RA_Elephant <dbl>, RA_Monkeys <dbl>, RA_Rodent <dbl>, RA_Ungulate <dbl>,
## #   Rich_AllSpecies <dbl>, Evenness_AllSpecies <dbl>,
## #   Diversity_AllSpecies <dbl>, Rich_BirdSpecies <dbl>,
## #   Evenness_BirdSpecies <dbl>, Diversity_BirdSpecies <dbl>,
## #   Rich_MammalSpecies <dbl>, Evenness_MammalSpecies <dbl>,
## #   Diversity_MammalSpecies <dbl>
```

```r
glimpse(vertebrate_community_composition)
```

```
## Rows: 24
## Columns: 26
## $ TransectID              <dbl> 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, 16,…
## $ Distance                <dbl> 7.14, 17.31, 18.32, 20.85, 15.95, 17.47, 24.0…
## $ HuntCat                 <chr> "Moderate", "None", "None", "None", "None", "…
## $ NumHouseholds           <dbl> 54, 54, 29, 29, 29, 29, 29, 54, 25, 73, 46, 5…
## $ LandUse                 <chr> "Park", "Park", "Park", "Logging", "Park", "P…
## $ Veg_Rich                <dbl> 16.67, 15.75, 16.88, 12.44, 17.13, 16.50, 14.…
## $ Veg_Stems               <dbl> 31.20, 37.44, 32.33, 29.39, 36.00, 29.22, 31.…
## $ Veg_liana               <dbl> 5.78, 13.25, 4.75, 9.78, 13.25, 12.88, 8.38, …
## $ Veg_DBH                 <dbl> 49.57, 34.59, 42.82, 36.62, 41.52, 44.07, 51.…
## $ Veg_Canopy              <dbl> 3.78, 3.75, 3.43, 3.75, 3.88, 2.50, 4.00, 4.0…
## $ Veg_Understory          <dbl> 2.89, 3.88, 3.00, 2.75, 3.25, 3.00, 2.38, 2.7…
## $ RA_Apes                 <dbl> 1.87, 0.00, 4.49, 12.93, 0.00, 2.48, 3.78, 6.…
## $ RA_Birds                <dbl> 52.66, 52.17, 37.44, 59.29, 52.62, 38.64, 42.…
## $ RA_Elephant             <dbl> 0.00, 0.86, 1.33, 0.56, 1.00, 0.00, 1.11, 0.4…
## $ RA_Monkeys              <dbl> 38.59, 28.53, 41.82, 19.85, 41.34, 43.29, 46.…
## $ RA_Rodent               <dbl> 4.22, 6.04, 1.06, 3.66, 2.52, 1.83, 3.10, 1.2…
## $ RA_Ungulate             <dbl> 2.66, 12.41, 13.86, 3.71, 2.53, 13.75, 3.10, …
## $ Rich_AllSpecies         <dbl> 22, 20, 22, 19, 20, 22, 23, 19, 19, 19, 21, 2…
## $ Evenness_AllSpecies     <dbl> 0.793, 0.773, 0.740, 0.681, 0.811, 0.786, 0.8…
## $ Diversity_AllSpecies    <dbl> 2.452, 2.314, 2.288, 2.006, 2.431, 2.429, 2.5…
## $ Rich_BirdSpecies        <dbl> 11, 10, 11, 8, 8, 10, 11, 11, 11, 9, 11, 11, …
## $ Evenness_BirdSpecies    <dbl> 0.732, 0.704, 0.688, 0.559, 0.799, 0.771, 0.8…
## $ Diversity_BirdSpecies   <dbl> 1.756, 1.620, 1.649, 1.162, 1.660, 1.775, 1.9…
## $ Rich_MammalSpecies      <dbl> 11, 10, 11, 11, 12, 12, 12, 8, 8, 10, 10, 11,…
## $ Evenness_MammalSpecies  <dbl> 0.736, 0.705, 0.650, 0.619, 0.736, 0.694, 0.7…
## $ Diversity_MammalSpecies <dbl> 1.764, 1.624, 1.558, 1.484, 1.829, 1.725, 1.9…
```

```r
HuntCat <- as.factor("HuntCat")
LandUse <- as.factor("LandUse")
```

```r
class(HuntCat)
```

```
## [1] "factor"
```

```r
class(LandUse)
```

```
## [1] "factor"
```

**10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?**

```r
vertebrate_community_composition %>% 
  group_by(HuntCat) %>% 
  filter(HuntCat != "None") %>% 
  summarise(mean_bird_diversity = mean(Diversity_BirdSpecies),
            mean_mammal_diversity = mean(Diversity_MammalSpecies),
            n_total = n())
```

```
## # A tibble: 2 x 4
##   HuntCat  mean_bird_diversity mean_mammal_diversity n_total
##   <chr>                  <dbl>                 <dbl>   <int>
## 1 High                    1.66                  1.74       7
## 2 Moderate                1.62                  1.68       8
```

**11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 5km from a village to sites that are greater than 20km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.**  

```r
vertebrate_community_composition %>% 
  group_by(Distance) %>% 
  filter(Distance < 5 | Distance > 20) %>% 
  summarise(across(c(RA_Apes, RA_Birds, RA_Elephant, RA_Monkeys, RA_Rodent, RA_Ungulate)))
```

```
## # A tibble: 6 x 7
##   Distance RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent RA_Ungulate
##      <dbl>   <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1     2.7     0        85.0       0.290       9.09      3.74        1.86
## 2     2.92    0.24     68.2       0          25.6       4.05        1.88
## 3     3.83    0        57.8       0          37.8       3.19        1.04
## 4    20.8    12.9      59.3       0.56       19.8       3.66        3.71
## 5    24.1     3.78     42.7       1.11       46.2       3.1         3.1 
## 6    26.8     4.91     31.6       0          54.1       1.29        8.12
```

**12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`**

```r
vertebrate_community_composition %>%
  group_by(LandUse) %>% 
  summarise(mean_veg_rich = mean(Veg_Rich, na.rm = T),
            mean_rich_allspecies = mean(Rich_AllSpecies, na.rm = T),
            mean_rich_birdspecies = mean(Rich_BirdSpecies, na.rm = T),
            mean_rich_mammalspecies = mean(Rich_MammalSpecies, na.rm = T),
            n_total = n()) %>% 
  arrange(desc(mean_veg_rich))
```

```
## # A tibble: 3 x 6
##   LandUse mean_veg_rich mean_rich_allsp… mean_rich_birds… mean_rich_mamma…
##   <chr>           <dbl>            <dbl>            <dbl>            <dbl>
## 1 Park             16.3             21.9             10.4            11.4 
## 2 Logging          14.4             19.6             10.2             9.38
## 3 Neither          13.5             19.2             10.5             8.75
## # … with 1 more variable: n_total <int>
```
