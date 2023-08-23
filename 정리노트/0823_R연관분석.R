install.packages("arules")
library(arules)

data("Groceries")
str(Groceries)
Groceries
inspect(Groceries) # 169개의 트랜잭션 항목 출력

summary(Groceries)

Groceries.df<-as(Groceries,"data.frame")
head(Groceries.df)

apriori(트랜잭션_data, parameter=list(supp, conf))

rule<-apriori(Groceries, parameter = list(supp=0.001, conf=0.8))
inspect(rule) # 발견된 규칙 출력

install.packages("arulesViz")
library(arulesViz)

plot(rule, method="grouped")

rule<-apriori(Groceries, parameter = list(supp=0.001, conf=0.8, maxlen=3))
inspect(rule)

rule<-sort(rule, by="confidence")
inspect(rule)

rule<-sort(rule, by="lift")
inspect(head(rule,5))

plot(rule, method="graph",control = list(type="items"))

wmlik<-subset(rule, rhs %in% 'whole milk') # lhs: 왼쪽 item
wmlik
inspect(wmlik)
plot(wmlik, method="graph") # 연관 네트워크 그래프

# 1) 오른쪽 item이 other vegetables인 규칙만 서브셋으로 작성하고 그래프 그리기
other_vegetables<-subset(rule, rhs %in% 'other vegetables')
other_vegetables
inspect(other_vegetables)
plot(other_vegetables, method="graph")

# 2) 오른쪽 item이 vegetables인 단어가 포함된(포함문자 : %pin%) 규칙만 서브셋으로 작성하고 그래프 그리기

vegetables<-subset(rule, rhs %pin% 'vegetables')
vegetables
inspect(vegetables)
plot(vegetables, method="graph")

# 3) 왼쪽 item이 butter or yogurt인 규칙만 서브셋으로 작성하고 그래프 그리기

boy <-subset(rule, lhs %in% c('butter', 'yogurt'))
boy
inspect(boy)
plot(boy, method="graph")