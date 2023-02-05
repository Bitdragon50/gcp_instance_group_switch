import requests
from pprint import pprint
from googleapiclient import discovery
import google.auth
import functions_framework

project = "kubernetes-the-hardway-357008"
region = "europe-west2"
credentials, project = google.auth.default()
service = discovery.build('compute', 'v1', credentials=credentials)
size = 1

@functions_framework.http
def switch(request):
    call = service.regionInstanceGroupManagers().list(project=project, region=region)
    response = call.execute()
    items    = response['items']
    ig_names = []

    for igm in items:
        ig_names.append(igm['name'])
        print(ig_names)
    

    for igm in ig_names:
        call = service.regionInstanceGroupManagers().resize(project=project, region=region, instanceGroupManager=f"{igm}", size=size)
        response = call.execute()

    for igm in items:
        print(f'The size of {igm["name"]} is {igm["targetSize"]}')

    return "Instance groups have been switched on. Have a great Week."
   

# switch(1)return
