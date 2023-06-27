import numpy as np
import pandas as pd
#Gerekli olan kutuphaneleri import ettik

#pandas kutuphanesini kullanarak tek satırda 2 mean değeri de tanımlandı
ortalamalar = pd.DataFrame({"mean1":[3,2],"mean2":[5,4]})

#numpy kutuphanesini kullanarak kovaryans matrislerini tanımladım
cov1 = np.array([[0.5,0],[0,0.5]])
cov2 = np.array([[1,0],[0,1]])

#Yazılı olarak buldugum karar egrisi denklemini koda gecirdim
def karar_egrisi(x,y):
    denklem = 0.5*x**2 + 0.5*y**2 -x #Denklemin kendisi
    if(denklem > 7.5):
        return 2 #Bu durumda 2.sınıfa duser
    else:
        return 1 #Bu durumda 1.sınıfa duser
    
#Ortalamasi ve cov degeri belli olan normal dagilim seklinde 100er adet 2B oznitelik vektor uretildi.
veri1 = np.random.multivariate_normal(ortalamalar["mean1"], cov1,100).T
veri2 = np.random.multivariate_normal(ortalamalar["mean2"], cov2,100).T

a,b,c,d = 0,0,0,0 #Ninovaya yuklenen kaynaktaki confusion matrisindeki a,b,c,d degerlerini tanimladim.
#Karistirma matrisinin algoritmasini for dongusuyle kurdum
for i in range(100): #100 denemede sonuc1 ve sonuc2 icin karar egrisi kontrol ediliyor. Toplamda 200 deneme eder.
    sonuc1 = karar_egrisi(veri1[0][i], veri1[1][i]) #a,b,c,d seklinde verilen degerler confusion matrisinde bulunan degerler.
    if(sonuc1 == 1):
        a+=1
    else:
        b+=1
    sonuc2=karar_egrisi(veri2[0][i], veri2[1][i])
    if(sonuc2 == 2):
        d+=1
    else:
        c+=1
#Son olarak confusion matris indexlerine isim vererek özelleştiriyoruz.
conf_mat = pd.DataFrame(data={'Positive': [a,c], 'Negative': [b,d]},index=["True","False"])