# Outlier Detection 
### Algorithm – Outlier Detection using K-Nearest Neighbor Data Distributions

The outlier algorithm  [is described in this paper in detail on page 10-11][1], but to summarize it works like this:

1. Find the set S(K) of K nearest neighbors to the test data point O.
2. Calculate the K distances between O and the members of S(K). These distances define fK(d,O).
3. Calculate the K(K-1)/2 distances among the points within S(K). These distances define fK(d,K).
4. Compute the cumulative distribution functions CK(d,O) and CK(d,K), respectively, for fK(d,O) and fK(d,K).
5. Perform the K-S Test on CK(d,O) and CK(d,K). Estimate the p-value of the test.
6. Calculate the Outlier Index = 1-p. 

### Outlier Classification:
- If Outlier Index > 0.95, then mark O as an “Outlier”. The Null Hypothesis is rejected. 
- If 0.90 < Outlier Index < 0.95, then mark O as a “Potential Outlier”. 
- If p > 0.10, then the Null Hypothesis is accepted: the two distance distributions are drawn from the same population. Data point O is not marked as an outlier.

[1]: http://kirkborne.net/TenurePortfolio/kirkborne/10%20Supporting%20Evaluative%20Materials/Journal%20papers%20-%20submitted%20-%20in%20review/Borne-ML2010-Effective%20Outlier%20Detection.pdf
