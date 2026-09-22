# Plotting helper functions -------

#' Scientific log10 labeller
#'
#' Nicely formatted labeller for log10 scales scale_y_log10(label = label_scientific_log())
label_scientific_log <- function() {
  parser1 <- scales::label_scientific()
  parser2 <- scales::label_parse()
  parser3 <- scales::label_log()
  function(x) {
    needs_decimal <- any((log10(na.omit(x)) %% 1) > 0)
    if (needs_decimal) {
      out <- x |>
        parser1() |>
        stringr::str_replace("e\\+?", " %.% 10^") |>
        parser2()
    } else {
      out <- parser3(x)
    }
    out[x == 0.0] <- 0
    return(out)
  }
}

#' Latex labeller
#'
#' Latex labeller for ggplot that will interpret latex equations correctly (i.e. anything between $$).
#' Works for both the \code{labels} parameter of discrete ggplot2 scales as well as the \code{labeller} of facets.
#' @param whether to display the labels of multiple facet factors on separate lines.
label_latex <- function(multi_line = TRUE) {
  fun <- function(labels, ...) {
    # safe latex conversion
    latex_to_expr <- function(x) {
      purrr::map(
        x,
        ~ {
          if (is.na(.x)) {
            NA_character_
          } else {
            latex2exp::TeX(.x)
          }
        }
      )
    }

    # parse labels
    if (is(labels, "data.frame")) {
      labels <- labels |>
        ggplot2::label_value(multi_line = multi_line) |>
        purrr::map(latex_to_expr)
    } else {
      labels <- labels |>
        latex_to_expr()
    }
    # return
    return(labels)
  }

  structure(fun, class = c("function", "labeller"))
}


#' Generate a regression fit label to show on plots
#'
#' @param df the data frame - use group_by to make sure all relevant aesthetics are accounted for
#' @param formula the regression formula
#' @param func the regression function
#' @param signif number of significant digits in the terms (uses format_with_signif function)
#' @param include_r2 whether to include the adjusted R2 term
#' @param terms_order_low_to_high whether to start with the intercept and go to higher order terms or vice versa (start with highest order term)
#' @param ... additional parameters to the regression function
generate_regression_fit_label <- function(
  df,
  formula,
  func = lm,
  signif = 2,
  include_r2 = TRUE,
  terms_order_low_to_high = FALSE,
  ...
) {
  if (missing(formula)) {
    stop("need a formula", call. = FALSE)
  }
  formula_expr <- rlang::enexpr(formula)
  safe_func <- purrr::safely(func)
  dots <- rlang::dots_list(...)
  df |>
    dplyr::group_nest(.key = "reg_data") |>
    dplyr::mutate(
      fit = purrr::map(
        reg_data,
        ~ safe_func(formula = !!formula_expr, data = .x, !!!dots)
      ),
      has_error = !purrr::map_lgl(fit, ~ is.null(.x$error)),
      error_msg = purrr::map2_chr(
        has_error,
        fit,
        ~ if (.x) {
          as.character(.y$error)
        } else {
          NA_character_
        }
      ),
      adj_r2 = purrr::map2_dbl(
        has_error,
        fit,
        ~ if (!.x) {
          broom::glance(.y$result)$adj.r.squared
        } else {
          NA_real_
        }
      ),
      coefs = purrr::map2(
        has_error,
        fit,
        ~ if (!.x) {
          coeffs <- broom::tidy(.y$result)
          if (!terms_order_low_to_high) {
            coeffs <- coeffs[nrow(coeffs):1, ]
          }
          coeffs |>
            dplyr::mutate(
              term = stringr::str_remove_all(term, stringr::fixed("`")),
              x_term = dplyr::case_when(
                is.na(estimate) ~ sprintf("??\\cdot{}\\textit{%s}", term),
                term == "(Intercept)" ~ format_with_signif(
                  estimate,
                  signif = !!signif,
                  sci_as_latex = TRUE,
                  include_plus = TRUE
                ),
                TRUE ~ sprintf(
                  "%s\\cdot{}\\textit{%s}",
                  format_with_signif(
                    estimate,
                    signif = signif,
                    sci_as_latex = TRUE,
                    include_plus = TRUE
                  ),
                  term
                )
              )
            )
        } else {
          NULL
        }
      ),
      y_term = sprintf(
        "\\textit{%s}",
        rlang::as_label(rlang::f_lhs(!!formula_expr))
      ),
      x_term = purrr::map2_chr(
        has_error,
        coefs,
        ~ if (!.x) {
          paste(.y$x_term, collapse = "\\,")
        } else {
          NA_character_
        }
      ),
      r2_term = if (include_r2) {
        sprintf(
          "\\,(\\textit{r}^2 = %s)",
          format_with_signif(adj_r2, signif = signif, sci_as_latex = TRUE)
        )
      },
      latex_label = ifelse(
        has_error,
        NA_character_,
        sprintf("$%s\\,=\\,%s%s$", y_term, x_term, r2_term)
      ),
      expr_label = purrr::map2_chr(
        latex_label,
        error_msg,
        ~ as.character(latex2exp::TeX(
          if (!is.na(.x)) {
            .x
          } else {
            .y
          }
        ))
      )
    ) |>
    dplyr::select(
      -"reg_data",
      -"fit",
      -"adj_r2",
      -"coefs",
      -"y_term",
      -"x_term",
      -"r2_term"
    )
}

#' Format number with significant digits
#'
#' This is useful for including numbers on plots as text elements.
#'
#' @param signif number of significant digits to display
#' @param no_sci_min use scientific notation for abs(x)<=no_sci_min, only used if always_sci = FALSE
#' @param no_sci_max use scientific notation for abs(x)>=no_sci_max, only used if always_sci = FALSE
#' @param alawys_sci set to TRUE to always use scientific notation
#' @param sci_as_latex whether to print scientific notation as latex
#' @param include_plus whether to include plus sign for positive numbers (x>0)
#' @param na_value what value to use for NA values
#' @return textual representation of the number matching the parameter settings
format_with_signif <- function(
  x,
  signif = 2,
  no_sci_min = 1e-5,
  no_sci_max = 1e5,
  always_sci = FALSE,
  sci_as_latex = FALSE,
  include_plus = FALSE,
  na_value = NA_character_
) {
  if (signif <= 0) {
    stop(
      "this function only supports numbers with at least 1 significant digit"
    )
  }
  x <- base::signif(x, digits = signif)
  n_decimals = ifelse(x == 0, 0, log10(abs(x)))
  # find decimals depending on whether it's an exact power of 10 or not
  exact <- (n_decimals %% 1) < .Machine$double.eps^0.5
  n_decimals <- ifelse(exact, n_decimals, floor(n_decimals))
  # use same decimals for true 0 as the smallest abs(x)
  zeros <- abs(x) < .Machine$double.eps
  zeros[is.na(zeros)] <- FALSE
  if (any(zeros)) {
    min_decimals <- min(n_decimals[!zeros], na.rm = TRUE)
    n_decimals <- ifelse(zeros, min_decimals, n_decimals)
  }
  # determine formatting
  plus <- if (include_plus) "+" else ""
  pow <- if (sci_as_latex) "\\\\cdot{}10^{%.0f}" else "e%.0f"
  # generate output vector
  out <- character(length(x))
  out[is.na(x)] <- na_value
  # non-sci formatting
  non_sci <- !is.na(x) & !always_sci & abs(x) > no_sci_min & abs(x) < no_sci_max
  out[non_sci] <- sprintf(
    sprintf("%%%s.%0.ff", plus, -n_decimals[non_sci] + signif - 1L),
    x[non_sci]
  )
  # sci formatting
  sci <- !is.na(x) & !non_sci
  out[sci] <- sprintf(
    sprintf("%%%s.%0.ff%s", plus, signif - 1L, pow),
    x[sci] * 10^(-n_decimals[sci]),
    n_decimals[sci]
  )
  # finished
  return(out)
}
