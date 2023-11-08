import numpy as np
from skimage.io import imread
from skimage.measure import block_reduce
import glob
from sklearn.decomposition import PCA
from PIL import Image
from sklearn.decomposition import PCA

foto_yolu = r"C:\Users\yigit\Desktop\odev2\yuzler\*.pgm"

foto_yolu = glob.glob(foto_yolu)

yuz_matrisi = []

for face in foto_yolu:
    foto = imread(face)
    foto = block_reduce(foto,block_size=(4,4), func=np.mean)
    foto = np.array(foto.flatten())
    yuz_matrisi.append(foto)

yuz_matrisi = np.array(yuz_matrisi)
pca = PCA()
pca.fit(yuz_matrisi)

kovaryans = pca.get_covariance()
vektor = pca.components_
value = pca.explained_variance_

"""
for i in range(10):
    foto_cikti =  Image.fromarray(vektor[i].reshape(48,42)*2048)
    foto_cikti.show()
"""

cikti = np.matmul(vektor,kovaryans)

cikti = cikti.T
ters = np.linalg.inv(np.matmul(cikti.T,cikti))
project = np.matmul(cikti, ters)
project = np.matmul(project, cikti.T)
cikti_yeni = np.matmul(yuz_matrisi, project)
"""
for i in range(10):
    foto_cikti =  Image.fromarray(cikti_yeni[i].reshape(48,42))
    foto_cikti.show()
"""
oklid = []
for i in range(10):
    temp = np.linalg.norm(yuz_matrisi[i]- cikti_yeni[i])
    oklid.append(temp)
for i in range(10):
    print("",i+1,". ","",oklid[i])

  foto_yolu =r"C:\Users\em_re\Desktop\Dersler\ML\ML_odevler\EmreAkcinOdev2\face\*.pgm"
