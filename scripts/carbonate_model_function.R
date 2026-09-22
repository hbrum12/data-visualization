#' convert back and forth between VPDB and VSMOW scale
#' @return delta value in permil
convert_vpdb_to_vsmow <- function(d.permil) {
  d.permil * 1.03092 + 30.92
}
convert_vsmow_to_vpdb <- function(d.permil) {
  (d.permil - 30.92) / 1.03092
}

# calcualte fraction factor
calculate_alpha <- function(temp.C) {
  temp.K <- 273.15 + temp.C
  exp(18.03 / temp.K - 32.42 / 1e3)
}

# convert between delta of CaCO3 and H2O (in VPDB scale)
#' @param temp.C temperature in Celsius, will be used to calcualte alpha if alpha is not provided
#' @param alpha fractionation factor
#' @return delta value in permil
calculate_d_CaCO3_from_H2O <- function(
  d_H2O.permil,
  temp.C,
  alpha = calculate_alpha(temp.C)
) {
  ((d_H2O.permil / 1000 + 1) * alpha - 1) * 1000
}

calculate_d_H2O_from_CaCO3 <- function(
  d_CaCO3.permil,
  temp.C,
  alpha = calculate_alpha(temp.C)
) {
  ((d_CaCO3.permil / 1000 + 1) / alpha - 1) * 1000
}
