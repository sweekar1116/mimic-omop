#!/usr/bin/Rscript
#
# Generates a sql template
#

mapping_file  <- commandArgs(TRUE)[1]
mapping_file_path  <- gsub("mapping.csv","",mapping_file, perl=TRUE)
mapping_data <- read.csv(mapping_file)
mapping_data <- mapping_data[!mapping_data$mimic_table%in%c("","NULL"),]
sql <- ' WITH %s \n %s'


gen_with_stmt <- function(df){
	agg <- with(df, aggregate(paste0(mimic_column," as ",omop_column) , list(mimic_table=factor(mimic_table, levels=unique(mimic_table))), paste, collapse=", "))
	paste0(agg$mimic_table, " AS (SELECT ", agg$x, " FROM ", paste0("mimic.",agg$mimic_table), ")", collapse=",\n")
}


gen_insert_stmt <- function(df){
	mimic_agg <- with(df, aggregate(mimic_column, list(mimic_table = factor(mimic_table, levels= unique(mimic_table))), paste, collapse=", "))
	omop_agg <- with(df, aggregate(omop_column, list(mimic_table = factor(mimic_table, levels= unique(mimic_table))), paste, collapse=", "))
	omop_columns <- paste0(omop_agg$x, collapse = ", ")
	mimic_select <- with(df, paste0(mimic_table,".",omop_column, collapse = ", "))
	mimic_from <- paste0(with(df,  paste0( " LEFT JOIN ", unique(mimic_table), collapse = " ON ()\n")), " ON ()")
	sql <- "INSERT INTO omop.%s (%s)\n SELECT %s \nFROM %s "
	sprintf(sql, df[1,"omop_table"], omop_columns, mimic_select, gsub("^ LEFT JOIN (\\w*) ON \\(\\)", "\\1", mimic_from, perl=TRUE)) 
}


with_stmt <- gen_with_stmt(mapping_data)
ins_stmt <- gen_insert_stmt(mapping_data)
stmt <- sprintf(sql, with_stmt, ins_stmt)
cat(stmt, file=file.path(mapping_file_path, "etl_template.sql"))
