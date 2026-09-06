# ============================================================
# load_power_prefilter.R
#
# Load only rows within a date range from
# household_power_consumption.txt by pre-filtering with awk
# (fast, C-based, streams the file) into a small temp file,
# then reading that small file into R.
# ============================================================

load_power_prefilter <- function(file       = "household_power_consumption.txt",
                                 start_date = "1/2/2007",
                                 end_date   = "2/2/2007",
                                 subsetFile = "power_subset.txt") {
  
  # --- Check the input file exists before doing any work ---
  if (!file.exists(file))
    stop(sprintf("Input file not found: '%s'", file))
  
  # Convert dd/mm/yyyy -> yyyymmdd integer for awk comparison.
  toKey <- function(dstr) {
    p <- as.integer(strsplit(dstr, "/")[[1]])   # c(dd, mm, yyyy)
    p[3] * 10000L + p[2] * 100L + p[1]
  }
  startKey <- toKey(start_date)
  endKey   <- toKey(end_date)
  
  # Build the awk program: keep header, then rows whose date key is in range.
  awkProg <- sprintf(
    'NR==1 { print; next } { split($1,p,"/"); k=p[3]*10000+p[2]*100+p[1]; if (k>=%d && k<=%d) print }',
    startKey, endKey)
  
  # Run the pre-filter. shQuote guards the file names.
  cmd <- sprintf("awk -F';' %s %s > %s",
                 shQuote(awkProg), shQuote(file), shQuote(subsetFile))
  status <- system(cmd)
  if (status != 0) stop("awk pre-filter failed.")
  
  # Read the small subset file.
  data <- read.table(subsetFile, header = TRUE, sep = ";", na.strings = "?",
                     colClasses = c("character", "character", rep("numeric", 7)))
  
  # Combined DateTime column.
  # POSIXct
  data$DateTime <- as.POSIXct(paste(data$Date, data$Time),
                              format = "%d/%m/%Y %H:%M:%S")
  
  data
}
