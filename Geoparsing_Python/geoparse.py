import requests
import csv

inputfile = open('placelist.txt','r')
outputfile = csv.writer(open('geocoded-placelist.txt','w'))

for row in inputfile:
  row = row.rstrip()
  url = 'http://maps.googleapis.com/maps/api/geocode/json'
  payload = {'address':row, 'sensor':'false'}
  r = requests.get(url, params=payload)

  if r.status_code == 200:
      json = r.json()

      if json.get("results", []):
          lat = json['results'][0]['geometry']['location']['lat']
          lng = json['results'][0]['geometry']['location']['lng']

          newrow = [row,lat,lng]
          outputfile.writerow(newrow)
