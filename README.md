jbkmisc
================

[![Travis-CI Build Status](https://travis-ci.org/jbkunst/jbkmisc.svg?branch=master)](https://travis-ci.org/jbkunst/jbkmisc)

date
----

-   `ym_to_date`

``` r
ym_to_date(ym = c(200902, 201912), day = 1)
```

    ## [1] "2009-02-01" "2019-12-01"

-   `ym_diff`

``` r
ym_diff(ym = c(200902, 201912), ym2 = c(200901, 201712))
```

    ## [1]  1 24

dplyrs
------

-   `ccount`

``` r
ccount(iris, Species)
```

|    n|   nn|
|----:|----:|
|   50|    3|

shiny
-----

-   `get_my_local_ip`

``` r
get_my_local_ip()
```

    ## [1] "10.27.5.239"

Workflow
--------

-   `wf_create_folders`: crate data, code and output folder.

ggtheme
-------

-   `theme_jbk`

blog
----

-   `spin_jekyll_post`: My custom spin r file to md and move the widgets, etc.
-   `blog_set_chunk`: Set opt chunk with my preferences
-   `giphy`: Put a giphy image given the id.

databases
---------

-   `sqlQuery`: A wrapper for `RODBC::sqlQuery` but adding `tbl_df` class.
-   `sqlquery2`: Do a sqlQuery given a channel, a table name and fields. If there are a sum, count etc, aumatically do the group by with the other fields
