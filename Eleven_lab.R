#renv::init() # инициализация виртуального окружения
#renv::install("AppliedPredictiveModeling") # установка библиотеки из CRAN
#renv::snapshot() # делаем снимок версий библиотек в нашем виртуальном окружении
# фиксируем этот список в .lock-файле для возможности восстановления
# renv::restore() # команда отктиться к предыдушему удачному обновления библиотек

# ------------------- 
# Лабораторная работа №11:
# Разделение данных на обучающую и тестовую выборки.

library(AppliedPredictiveModeling)
library(caret)
# Простое случайное разделение данных


# инициализация генератора случайных чисел для воспроизведения результатов
set.seed(1233)
# по-умолчанию числа возвращаются в виде списка. С параметром list = FALSE генерируется
# матрица номеров строк
# эти данные выделяются в тренировочный набор

train<-read.csv("iris.csv")
train

trainingRows<-caret::createDataPartition(train$sepal.length,p=0.80,list=FALSE)# матрица

validation<-train[trainingRows,]
validation

dataset<-train[-trainingRows,]
dataset
write.csv(validation,file="validation.csv")
write.csv(dataset,file="dataset.csv")
# ------------------- 
# Повторная выборка
# caret  способен генерировать разделение тренировочного/тестового набора с дополнительным аргументом
# times (для создания множественных вариантов разделения)



# кроме того, в пакете caret есть ф-ия createResamples() для выборки с возвратом
# createFolds() для К-кратной перекрестной проверки и createMultuFolds() для повторной перекрестной проверки

# Чтобы создать индикаторы для десятикратной перекрестной проверки выполните:
set.seed(1)
cvSplits <- caret::createFolds(train$variety, k=10,list=TRUE,
                               returnTrain = FALSE)

str(cvSplits)

# получение первого набора номеров строк из списка:
fold1 <- cvSplits[[1]]
fold1
# чтобы получить первые 90% данных (первая свертка) нужно:
cvPredictors1 <- train[fold1,]
cvClasses1 <- train[-fold1,]
nrow(cvPredictors1)
nrow(cvClasses1)
write.csv(cvPredictors1,file="cvPredictors1.csv")
write.csv(cvClasses1,file="cvClasses1.csv")
 

