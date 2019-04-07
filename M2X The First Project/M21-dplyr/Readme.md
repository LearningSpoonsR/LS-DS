# I. QnA 게시판 

<https://github.com/LearningSpoonsR/LS-DS/issues/6>

# II. `dplyr` eqivalent in Python 

<https://gist.github.com/conormm/fd8b1980c28dd21cfaf6975c86c74d07> 

## dplyr is organised around six key verbs

+ filter: subset a dataframe according to condition(s) in a variable(s)
+ select: choose a specific variable or set of variables
+ arrange: order dataframe by index or variable
+ group_by: create a grouped dataframe
+ summarise: reduce variable to summary variable (e.g. mean)
+ mutate: transform dataframe by adding new variables 

## `Filter`

#### R

```
filter(df, var > 20000 & var < 30000) 
filter(df, var == 'string') # df %>% filter(var != 'string')
df %>% filter(var != 'string')
df %>% group_by(group) %>% filter(sum(var) > 2000000)
```

#### Python 

```
df[(df['var'] > 20000) & (df['var'] < 30000)]
df[df['var'] == 'string']
df[df['var'] != 'string']
df.groupby('group').filter(lambda x: sum(x['var']) > 2000000)
```

## `Select`

#### R

```
select(df, var1, var2)
select(df, -var3)
```

#### Python

```
df[['var1', 'var2']]
df.drop('var3', 1)
```

## `Arrange`

#### R 

```
arrange(df, var1)
arrange(df, desc(var1))
``` 

#### Python 

```
df.sort_values('var1')
df.sort_values('var1', ascending=False)
```

## Grouping  

#### R

```
df %>% group_by(group) 
df %>% group_by(group1, group2)
df %>% ungroup()
```

#### Python  

```
df.groupby('group1')
df.groupby(['group1', 'group2'])
df.reset_index() / or when grouping: df.groupby('group1', as_index=False)
```


## `Summarise` / `Aggregate` df by group  

#### R

```
df %>% group_by(group) %>% summarise(mean_var1 = mean(var1))
df %>% group_by(group1, group2) %>% summarise(mean_var1 = mean(var1), 
                                              sum_var1 = sum(var1), 
                                              count_var1 = n())
```

#### Python

```
df.groupby('group1')['var1'].agg({'mean_col' : np.mean()}) 
# pass dict to specifiy column name

df.groupby(['group1', 'group2'])['var1]'].agg(['mean', 'sum', 'count']) 
# for count also consider 'size'. size will return n for NaN values also, whereas 'count' will not.
```

## Mutate / transform df by group

#### R

```
df %>% group_by(group) %>% mutate(mean_var1 = mean(var1))
```

### Python

```
df.groupby('group')['var1'].transform(np.mean)
```

## `Distinct` - remove duplicate obs from data frame

#### R

```
df %>% distinct()
df %>% distinct(col1) # returns dataframe with unique values of col1
```

#### Python

```
df.drop_duplicates()
df.drop_duplicates(subset='col1') # returns dataframe with unique values of col1
```

## Sample - generate random samples of the data by n or by %                   

#### R

```
sample_n(df, 100)
sample_frac(df, 0.5)
```

#### Python

```
df.sample(100)
df.sample(frac=0.5)                   
```

