# Coding : UTF-8

import numpy as np
import pandas as pd
from matplotlib import pylab as plt

#data = pd.read_csv('sample01.csv')
name=raw_input('>>CSV File Name : ')
data = pd.read_csv(name)


t=data.iloc[0:100000,0]
x=data.iloc[0:100000,4]
y=data.iloc[0:100000,5]

cop =[]
i=0
print '%d' % (x[10])
for n in range(len(t)):
    ans=np.sqrt(x[i]**2+y[i]**2)
    cop.append(ans)
    i+=1

plt.plot(t,cop)
plt.show()

plt.plot(x,y)
plt.show()
