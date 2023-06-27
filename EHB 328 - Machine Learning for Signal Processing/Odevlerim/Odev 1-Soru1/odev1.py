import pandas as pd

#irisdata.csv dosyasını aşağıdaki komut ile importluyoruz
iris_data = pd.read_csv("irisdata.csv")

#irisdata.csv dosyasında verilen çiçek türlerini 3 ayrı sınıfa ayırıyoruz.
setosa = iris_data.iloc[0:50]
versicolor = iris_data.iloc[50:100]
virginica = iris_data.iloc[100:150]

#pandas kütüphanesinde bulunan .mean() komutuyla birlikte 3 çiçeğin ayrı ayrı hesaplayarak ortalama değer vektörünü hesaplattım.
avg_setosa  = pd.DataFrame(setosa.mean())
avg_versicolor  = pd.DataFrame(versicolor.mean())
avg_virginica  = pd.DataFrame(virginica.mean())

#numpy kütüphanesinde bulunan np.cov ve np.array komutlarını kullanarak kovaryans matrislerini hesapladım.
setosa_cov_matrix= setosa.iloc[: , :4].cov()
versicolor_cov_matrix= versicolor.iloc[: , :4].cov()
virginica_cov_matrix= virginica.iloc[: , :4].cov()

#Sağlama yapmak için varyans hesabı yapalım. Cov matrisinde bulunan köşegen değerler varyansı ile eşleşip eşleşmediğine bakalım.
#Setosa'nın varyansını hesaplama
setosa_matrix = pd.DataFrame(setosa.iloc[: , :4])
setosa_var= setosa_matrix.var() #axis=0 değeriyle her sutünün varyans değerini hesaplıyorum.

#Versicolor'ın varyansını hesaplama
versicolor_matrix = pd.DataFrame(versicolor.iloc[: , :4])
versicolor_var= versicolor_matrix.var()

#Virginica'nın varyansını hesaplama
virginica_matrix = pd.DataFrame(virginica.iloc[: , :4])
virginica_var= virginica_matrix.var()