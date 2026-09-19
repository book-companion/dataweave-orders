%dw 2.0

/**
 * Parse the three date shapes the feed sends into a Date:
 * ISO (yyyy-MM-dd), US (MM/dd/yyyy), or an ISO timestamp (the date part).
 */
fun parseDate(s: String): Date =
  if (s matches /\d{4}-\d{2}-\d{2}T.*/)
    (s as DateTime) as Date
  else if (s matches /\d{4}-\d{2}-\d{2}/)
    (s as Date { format: "yyyy-MM-dd" })
  else
    (s as Date { format: "MM/dd/yyyy" })

/**
 * Element text like "29.50" into a real Number.
 */
fun money(s: String): Number = s as Number
