make_list_link <- function(dp, fn) {
   dp <- paste0(dp, "/", fn)  
   x1 <- "<li><a href=\""
   x2 <- "\"  target=\"blank\">"
   x3 <- "</a></li>\n"
   ans <- paste0(x1, dp, x2, fn, x3)
   return(ans)
}



## remove existing index file 
if (fs::file_exists("index.html")) {
    fs::file_delete("index.html")
}
fs::file_create("index.html")


cat("<!DOCTYPE html>\n", file="index.html" , append = TRUE)
cat("<html>\n", file="index.html" , append = TRUE)
cat("<body>\n", file="index.html" , append = TRUE)





## get current dir content
dp_current <- getwd()
dir_list   <- sort(fs::dir_ls(type="directory"))

for (j in seq_along(dir_list)) {

    dn_j <- dir_list[j]
    dp_j <- fs_path_expand(dn_j)
    
    tmp <- paste0("<h3>Dataset: ", dn_j, "</h3>")

    cat(tmp, file="index.html" , append = TRUE)
    cat("\n", file = "index.html" , append = TRUE)
    cat("<ul>",   file = "index.html" , append = TRUE)
    cat("\n",     file = "index.html" , append = TRUE)

    ## get into dataset folder 
    setwd(dp_j)
    dir_ls_j  <-  fs::dir_ls()

    ## readme file
    if(any(dir_ls_j == "readme.txt")) {
        i0 <- which(dir_ls_j == "readme.txt")   
        u <- make_list_link(dp = dn_j ,  fn = dir_ls_j[i0] )
        cat(u, file="../index.html" , append = TRUE)
        dir_ls_j <-dir_ls_j[-i0] 
    }

    ## other files 
    for (jj in seq_along(dir_ls_j)) {
        u <- make_list_link(dp = dn_j ,  fn = dir_ls_j[jj] )
        cat(u, file="../index.html" , append = TRUE)
    }

    setwd("..")

    cat("</ul>\n\n",    file="index.html" , append = TRUE)
    cat("<br>\n",    file="index.html" , append = TRUE)
    cat("\n\n", file="index.html" , append = TRUE)


    
} ## for (j in seq_along(dir_list))


cat("</body>\n", file="index.html" , append = TRUE)
cat("</html>\n", file="index.html" , append = TRUE)


