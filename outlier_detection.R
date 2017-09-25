
outlier_test <- function(data , neighbors){
  #Find the set S(K) of K nearest neighbors to the test data point O.
  sk <- nn2(data, k=neighbors)$nn.idx #matrix of indices of neighbors

  #Calculate the K distances between O and the members of S(K). These distances define fK(d,O).
  outlier_distances <- nn2(data, k=neighbors)$nn.dist #distances between value and its neighbors

  #Calculate the K(K-1)/2 distances among the points within S(K). These distances define fK(d,K).
  plyr::adply(sk, .margins = 1, function(row) { data[row, ] })

  df1<- plyr::alply(sk, .margins=1, function(row){data[row,]})
  df1 = plyr::ldply(df1, rbind)
  neighbor_distances <- plyr::alply(df1, 1, function(row) c(dist(unlist(row))))

  neighbor_distances <- df1 %>% 
    dplyr::group_by(X1) %>% 
    do({
      row_data <- .
      my_dist <- dist(row_data[ ,c(colnames(data)[1],colnames(data)[2])])
      as.data.frame(t(as.vector(my_dist)))
      }) %>% 
    dplyr::ungroup() %>% 
    dplyr::select(-X1) %>% 
    as.matrix()

  #daply(test, .(X1), function(x) as.vector(dist(x))) This  is an alternative way to do the above piping

  #Compute the cumulative distribution functions CK(d,O) and CK(d,K), respectively, for fK(d,O)
  #and fK(d,K).
  # Since ks.test function in R can take vectors of values, we don't need to explicitly find the ECDF of our samples

  #Perform the K-S Test on CK(d,O) and CK(d,K). Estimate the p-value of the test.
  all_pvalues = sapply(1:nrow(outlier_distances), function(i) ks.test(as.vector(outlier_distances[i,]), as.vector(neighbor_distances[i,]))$p.value)

  #Calculate the Outlier Index = 1-p.
  outlier_index = 1-all_pvalues
  #If Outlier Index > 0.95, then mark O as an Outlier. The Null Hypothesis is rejected.
  #If 0.90 < Outlier Index < 0.95, then mark O as a Potential Outlier.
  #If p > 0.10, then the Null Hypothesis is accepted: the two distance distributions are drawn from
  #the same population. Data point O is not marked as an outlier
  return(outlier_index)
}
