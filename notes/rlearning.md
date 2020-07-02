
#### Data and variables
快速查看数据
- base包里的`str()`
- dplyr包里的`glimpse()`

指令
- `if_else()`
- `case_when()`
- `droplevels()`
- `factor()` 把数值变量因子化
- `(y <- mean(x$z))` 可以既assign value也打印结果

#### Types of studies
- Observational
	- Collect data in a way that does not directly interfere with how the data arise
	- Only correlation can be inferred
- Experimental
	- Randomly assign subjects to various treatments
	- Causation can be inferred

<img src="rlearning-study-design.png" width="600">

#### Scope of inference
Random sampling & Random assignment

![random]("rlearning-random.png")

#### Sampling
1. Simple random sample
dplyr - `sample_n(size = 100)`

2. Stratified Sample (stratum)
dplyr
`group_by()
 sample_n(size = 100)`

3. Cluster Sample (cluster)
4. Multistage sample

#### Principles of experimental design
- Control: compare treatment of interest to a control group

- Randomize: randomly assign subjects to treatments

- Replicate: collect a sufficiently large sample within a study, or replicate the entire study

- Block: account for the potential effect of confounding variables
	- Group subjects into blocks based on these variables
	- Randomize within each block to treatment groups
