import sys
import json
import requests
import time

def getDataByLocation(latitude,longitude,from_iter,size_val):
	header_api={'X-Quikr-App-Id' : '521','X-Quikr-Token-Id':'2868423','X-Quikr-Signature':'f43ac2622cc4ec5bfa514938a1710e28d0a83b94'}
	url='https://api.quikr.com/public/adsByLocation?lat='+str(latitude)+'&lon='+str(longitude)+'&from='+str(from_iter)+'&size='+str(size_val)
	r=requests.get(url,headers=header_api)
	writeToFile('../data/dat_v0.json',r.json())

def getDataByCategory(cat_id,city,from_iter,size_val):
	header_api={'X-Quikr-App-Id' : '521','X-Quikr-Token-Id':'2868423','X-Quikr-Signature':'f4bf2469c97d3ad9b01d6ea96ad89823d16f5274'}
	url='https://api.quikr.com/public/adsByCategory?categoryId='+str(cat_id)+'&city='+city+'&from='+str(from_iter)+'&size='+str(size_val)
	session = requests.Session()
	session.trust_env = False
	r=session.get(url,headers=header_api)
	return r.json()

def getDataCity(city,file_loc,start,end):
	j_prev=''
	for i in range(start,end):
		jtxt=getDataByCategory(71,city,25*(i),25)	
		if jtxt==j_prev:
			break
		if i%200==0:
			sleepReq(30,city,'rest to servers')
		writeToFile('../data/'+file_loc+'/dat_'+str(i)+'.json',jtxt)
		j_prev=jtxt
	sleepReq(60,city)

def sleepReq(val,city,comment=''):
	if comment =='':
		print 'completed '+city+'. going to sleep \n'
	else:
		print comment +' in the city '+city
	time.sleep(val) 
	print 'back from sleep'

def getDataFull():
	#getDataCity('Delhi','cars_data/delhi_cars',970,1000)
	#getDataCity('Mumbai','cars_data/mumbai_cars',1,1000)
	getDataCity('Chennai','cars_data/chennai_cars',700,1000)
	getDataCity('Bangalore','cars_data/bangalore_cars',1,1000)
	getDataCity('Hyderabad','cars_data/hyderabad_cars',1,1000)
			
	
def writeToFile(file_name,txt):
	f=open(file_name,'w')
	f.write(str(json.dumps(txt)))


if __name__=='__main__':

	#getDataByLocation(28.64649963,77.22570038,26,2)
	#appendToFile('../data/dat_v0.json','hello')
	
	getDataFull()
